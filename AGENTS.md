# HomeSlot backend (Serverpod)

HomeSlot is a mobile app for booking shared rooms inside one household (SRS-002). This repository is the backend: a Serverpod 4 server (`homeslot_server`) and its generated Dart client (`homeslot_client`). The Flutter app lives in the separate `homeslot-frontend` repository and depends on `homeslot_client`.
Build for multiple users, use Serverpod's built-in authentication, which is already set up in `lib/server.dart`.

Key facts:

- Every endpoint sets `requireLogin` and goes through `Membership.requireMember` / `requireOwner` (`lib/src/services/membership.dart`). Never read or write household data without it.
- Booking rules are pure functions in `lib/src/services/booking_rules.dart` (unit tested). Services use `clock.now()` from `lib/src/util/clock.dart`, never `DateTime.now()`, so tests can control time.
- All times are stored in UTC; rules are evaluated in the household time zone (`TimeZones`).
- Double bookings are prevented by the `bookings_no_overlap` exclusion constraint (`lib/src/db/constraints.dart`). After `create_migration`, ALWAYS run `dart run tool/patch_migration.dart` in `homeslot_server` so the new migration contains it.
- User-facing error and notification text comes from `lib/src/util/messages.dart` (Thai and English).

The user starts the server with `serverpod start`. There is no need to check if the server is running: make the changes and call the `serverpod` MCP tools as needed. If the server is not running, an informative error message will be received from the MCP server. Then STOP and ask the user to start it. NEVER start the server yourself.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload the running server.

Calling `serverpod generate` directly is not needed, but might be useful to troubleshoot when an incremental generation fails.

ALWAYS use the MCP server instead of the command line. Use the MCP server to:

- `create_migration` and `apply_migrations` for database (after you change data models).
- `create_repair_migration` if the database has drifted out of sync with the migrations.
- `tail_server_logs` to read logs from the server.
- `hot_reload` / `hot_restart` to reload or restart the server. Use `hot_restart` for changes that hot reload cannot apply, such as changes to `main()`.

NEVER edit generated code. The server's `lib/src/generated/` directory and the whole `homeslot_client` package are rewritten by the code generator. Change the `.spy.yaml` models, the endpoints, or `lib/server.dart` instead.

Migrations are a narrow exception: the `migration.sql` of a generated migration MAY be edited by hand when the generated SQL would lose data — to add a data transformation, or to reach a destructive change through non-destructive steps. Never touch the other files in the migration directory, and keep the schema the SQL ends up with identical to `definition.sql` — new databases are created from that file and never run `migration.sql`.

Only when the server cannot be started at all, fall back to the CLI in the server package:

- `serverpod generate` to regenerate the client and the generated server code.
- `serverpod create-migration` after changing a model with a `table` (add `--force` for destructive changes). It only writes the migration; `serverpod start` applies pending migrations when it boots the server.

Tests need no Docker. `config/test.yaml` sets `database.dataPath`, so Serverpod starts and manages the test database (an embedded PostgreSQL) itself, and the project's `docker-compose.yaml` is not used for it. Just run `dart test` in the server package.

Checklist after doing changes, in this order:

- `dart analyze` (CLI)
- `dart format` (CLI)
- `create_migration` (MCP - only if necessary), then `dart run tool/patch_migration.dart` (CLI), then `apply_migrations` (MCP)
- Do `serverpod` MCP `hot_restart` if required (hot reload is done automatically)
- Run tests, if applicable (`dart test` in the server package)
- Check `serverpod` MCP `tail_server_logs` for any issues.
