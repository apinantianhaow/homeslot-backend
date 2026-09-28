import 'package:serverpod/serverpod.dart';

/// The overlap guard from SRS 4.4 / 4.8, enforced by PostgreSQL itself.
///
/// Serverpod's ORM creates and migrates the `bookings` table but cannot
/// express an exclusion constraint, and in development mode Serverpod 4
/// refuses to start when a managed table has an index it does not know.
/// So the exclusion constraint `bookings_no_overlap` lives on a small
/// companion table, `booking_slots`, that a trigger keeps in sync with every
/// insert and update of `bookings` in the same transaction. A booking that
/// would overlap an active booking of the same room therefore fails with
/// SQLSTATE 23P01, even when two requests arrive at the same moment.
///
/// * Only `pending` and `confirmed` bookings have a slot (SRS 2.4); other
///   statuses free the time immediately.
/// * Serverpod stores `DateTime` as `timestamp without time zone` in UTC, so
///   the range type is `tsrange` (with `timestamptz` it would be
///   `tstzrange`). `[)` includes the start and excludes the end:
///   10:00-11:00 and 11:00-12:00 do not overlap.
/// * With `btree_gist` (any standard PostgreSQL, including the Docker image
///   used for deployment) rooms are compared with `"roomId" WITH =`, as in
///   the SRS. PostgreSQL builds without the contrib extensions, such as the
///   embedded database Serverpod uses for development and tests, compare a
///   single-value `int8range` of the room id with the built-in range
///   operators instead. Both mean "same room".
///
/// `tool/patch_migration.dart` adds [sql] to every migration and [ensure]
/// runs it again at server start. The SQL is idempotent.
abstract final class DbConstraints {
  static const sql = r'''
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_available_extensions WHERE name = 'btree_gist'
  ) THEN
    EXECUTE 'CREATE EXTENSION IF NOT EXISTS btree_gist';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'bookings_valid_range'
  ) THEN
    ALTER TABLE "bookings"
      ADD CONSTRAINT bookings_valid_range CHECK ("endAt" > "startAt");
  END IF;

  CREATE TABLE IF NOT EXISTS "booking_slots" (
    "bookingId" bigint PRIMARY KEY
      REFERENCES "bookings" ("id") ON DELETE CASCADE,
    "roomId" bigint NOT NULL,
    "period" tsrange NOT NULL
  );

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'bookings_no_overlap'
  ) THEN
    IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'btree_gist') THEN
      ALTER TABLE "booking_slots"
        ADD CONSTRAINT bookings_no_overlap
        EXCLUDE USING gist ("roomId" WITH =, "period" WITH &&);
    ELSE
      ALTER TABLE "booking_slots"
        ADD COLUMN IF NOT EXISTS "roomRange" int8range
        GENERATED ALWAYS AS (int8range("roomId", "roomId", '[]')) STORED;
      ALTER TABLE "booking_slots"
        ADD CONSTRAINT bookings_no_overlap
        EXCLUDE USING gist ("roomRange" WITH &&, "period" WITH &&);
    END IF;
  END IF;
END
$$;

CREATE OR REPLACE FUNCTION homeslot_sync_booking_slot() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  IF NEW."status" IN ('pending', 'confirmed') THEN
    INSERT INTO "booking_slots" ("bookingId", "roomId", "period")
    VALUES (NEW."id", NEW."roomId", tsrange(NEW."startAt", NEW."endAt", '[)'))
    ON CONFLICT ("bookingId") DO UPDATE
      SET "roomId" = EXCLUDED."roomId", "period" = EXCLUDED."period";
  ELSE
    DELETE FROM "booking_slots" WHERE "bookingId" = NEW."id";
  END IF;
  RETURN NULL;
END
$$;

CREATE OR REPLACE TRIGGER bookings_sync_slot
  AFTER INSERT OR UPDATE ON "bookings"
  FOR EACH ROW EXECUTE FUNCTION homeslot_sync_booking_slot();

INSERT INTO "booking_slots" ("bookingId", "roomId", "period")
SELECT "id", "roomId", tsrange("startAt", "endAt", '[)')
FROM "bookings"
WHERE "status" IN ('pending', 'confirmed')
ON CONFLICT ("bookingId") DO NOTHING;
''';

  static Future<void> ensure(Session session) async {
    await session.db.unsafeSimpleExecute(sql);
  }
}
