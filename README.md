# HomeSlot Backend

Backend ของ **HomeSlot – แอปจองห้องภายในบ้าน** เขียนด้วย Dart บน [Serverpod 4](https://serverpod.dev) และ PostgreSQL ตามเอกสาร SRS-002 (28 ก.ย. 2569)

แอปมือถืออยู่ใน repository แยก: [`homeslot-frontend`](../homeslot-frontend)

```
homeslot-backend/
├── homeslot_server/   Serverpod server: endpoints, business rules, migrations, tests
├── homeslot_client/   Dart client ที่ Serverpod generate ให้ (แอป Flutter ใช้แพ็กเกจนี้)
├── e2e/               smoke test ที่คุยกับ server จริงผ่าน homeslot_client
└── deploy/            Docker Compose สำหรับ Raspberry Pi หรือ Cloud VPS
```

## เริ่มพัฒนา

ต้องมี Dart 3.12+ และ Serverpod CLI 4.0.3 (ไม่ต้องใช้ Docker ตอนพัฒนา: Serverpod เปิด PostgreSQL แบบ embedded ให้เอง)

```bash
dart pub global activate serverpod_cli 4.0.3
dart pub get
cp homeslot_server/config/passwords.example.yaml homeslot_server/config/passwords.yaml
#   แล้วแก้ค่า change-me ทุกตัวเป็นค่าสุ่ม (openssl rand -base64 32)

cd homeslot_server
serverpod start        # รัน server + ฐานข้อมูล + hot reload ที่ http://localhost:8080
```

- ในโหมด development รหัสยืนยันอีเมลและรหัสรีเซ็ตรหัสผ่านจะแสดงใน log ของ server (ตั้งค่า SMTP ใน `passwords.yaml` เพื่อส่งอีเมลจริง)
- Google Sign-In และ Push Notification เปิดใช้เมื่อใส่ `googleClientSecret` และ Firebase service account ตามตัวอย่างใน `config/passwords.example.yaml`

### หลังแก้ model หรือ endpoint

```bash
cd homeslot_server
serverpod generate                      # อัปเดตโค้ดฝั่ง server และ homeslot_client
serverpod create-migration              # ถ้าแก้ model ที่มี table
dart run tool/patch_migration.dart      # สำคัญ: ใส่ constraint กันจองซ้อนลงใน migration ใหม่
```

### ทดสอบ

```bash
cd homeslot_server
dart test                 # unit test กฎการจองทุกข้อ + integration test กับ PostgreSQL จริง
dart analyze && dart format --set-exit-if-changed lib test tool bin
```

`test/unit/booking_rules_test.dart` ครอบคลุมกฎการจองทุกข้อใน SRS 2.3 และ `test/integration/concurrency_test.dart` ยิงคำขอจองช่วงเวลาเดียวกันพร้อมกัน 10 คำขอ แล้วตรวจว่าสำเร็จได้แค่ 1 คำขอ (SRS 4.6) `test/integration/regression_test.dart` กันบั๊กที่พบจากการ review กลับมาอีก

### End-to-end smoke test (server จริง + HTTP/WebSocket)

```bash
cd homeslot_server
dart run bin/main.dart --apply-migrations > ../server.log 2>&1 &
cd ../e2e && dart run bin/e2e.dart ../server.log
```

สมัครสมาชิกด้วยอีเมลจริง (อ่านรหัสยืนยันจาก log), สร้างบ้าน, เชิญ, จอง, ตรวจการจองซ้อน, ยิงคำขอพร้อมกันผ่าน HTTP และวัดเวลาตาม SRS 4.2 (สร้างการจอง < 1 วินาที, real-time ถึงเครื่องอื่น < 2 วินาที)

ทุกครั้งที่ push ขึ้น GitHub จะรันทั้งหมดนี้ผ่าน GitHub Actions (`.github/workflows/ci.yml`)

## โครงสร้างโค้ด

| ส่วน | ไฟล์ | หน้าที่ |
|---|---|---|
| Models | `lib/src/models/**.spy.yaml` | ตาราง 10 ตาราง (users, households, household_members, invitations, rooms, room_hours, room_closures, booking_series, bookings, notifications, device_tokens ฯลฯ) และ DTO |
| กฎการจอง | `lib/src/services/booking_rules.dart` | ความละเอียดเวลา, ขั้นต่ำ/สูงสุด, จองล่วงหน้า, เวลาเปิดห้องรายวัน, ปิดห้องชั่วคราว, โควตารายสัปดาห์, ห้ามจองย้อนหลัง |
| เสนอช่วงว่าง | `lib/src/services/slot_finder.dart` | หาช่วงว่างที่ใกล้ที่สุดเมื่อจองไม่สำเร็จ |
| การจอง | `lib/src/services/booking_service.dart` | จอง, จองประจำรายสัปดาห์ (≤ 12 สัปดาห์), แก้ไข, ยกเลิก, คืนห้อง, อนุมัติ/ปฏิเสธ |
| บ้านและสมาชิก | `lib/src/services/household_service.dart` | สร้างบ้าน, รหัสเชิญ 6 หลัก (48 ชม., บล็อกเมื่อผิด 5 ครั้ง/15 นาที), บทบาท, ออกจากบ้าน, ลบบัญชี (PDPA) |
| ห้อง | `lib/src/services/room_service.dart` | CRUD ห้อง, เวลาเปิด, ปิดห้องชั่วคราว, สถานะห้องตอนนี้ |
| แจ้งเตือน | `notifier.dart`, `push_sender.dart`, `maintenance.dart` | ประวัติแจ้งเตือน 30 วัน, FCM, เตือนก่อนเวลา, หมดอายุคำขอ |
| Real-time | `lib/src/endpoints/events_endpoint.dart` | WebSocket stream ให้ปฏิทินอัปเดตทันที |
| สถิติ | `lib/src/services/stats_service.dart` | ชั่วโมงใช้งานรายห้อง/รายคน รายสัปดาห์/เดือน และ Peak Hours |
| กันจองซ้อน | `lib/src/db/constraints.dart` | Exclusion Constraint `bookings_no_overlap` ระดับฐานข้อมูล |

### Endpoints

ทุก endpoint ต้องเข้าสู่ระบบ และตรวจว่าเป็นสมาชิกบ้าน (หรือผู้ดูแลบ้าน) ที่ server ทุกครั้ง

| Endpoint | Methods |
|---|---|
| `account` | `me`, `updateProfile`, `updateSettings`, `registerDevice`, `unregisterDevice`, `deleteAccount` |
| `household` | `create`, `update`\*, `members`, `createInvite`\*, `activeInvites`\*, `revokeInvite`\*, `join`, `changeRole`\*, `removeMember`\*, `leave` |
| `room` | `list`, `get`, `statusNow`, `create`\*, `update`\*, `delete`\*, `close`\*, `removeClosure`\* |
| `booking` | `list`, `create`, `suggest`, `previewSeries`, `createSeries`, `update`, `cancel`, `release`, `mine`, `pending`\*, `approve`\*, `reject`\* |
| `stats` | `usage`\*, `peakHours`\* |
| `notification` | `list`, `unreadCount`, `markRead`, `markAllRead` |
| `events` | `subscribe` (stream) |
| `upload` | `createUpload`, `verifyUpload` |
| `emailIdp`, `googleIdp`, `jwtRefresh` | สมัคร/เข้าสู่ระบบ/รีเซ็ตรหัสผ่าน (โมดูล auth ของ Serverpod) |

\* เฉพาะผู้ดูแลบ้าน (Owner)

### การกันจองซ้อน (SRS 4.4, 4.8)

ทุกการจองผ่านกฎของห้องก่อน แล้วฐานข้อมูลเป็นด่านสุดท้าย Exclusion Constraint `bookings_no_overlap` ใช้ GiST กับช่วงเวลาแบบ `[)` จึงจองต่อกัน 10:00–11:00 กับ 11:00–12:00 ได้ แต่จองทับกันไม่ได้แม้ส่งคำขอพร้อมกัน ถ้าชนจะได้ `BookingException(overlap)` พร้อมช่วงว่างที่ใกล้ที่สุด

สิ่งที่ต่างจากตัวอย่าง SQL ใน SRS (ความหมายเหมือนเดิม):

- Serverpod เก็บ `DateTime` เป็น `timestamp without time zone` (UTC) จึงใช้ `tsrange` แทน `tstzrange`
- Serverpod 4 ไม่ยอมเปิด server ในโหมด development ถ้าตารางที่มันจัดการมี index ที่มันไม่รู้จัก จึงวาง constraint ไว้บนตารางคู่ `booking_slots` ที่ trigger บน `bookings` อัปเดตใน transaction เดียวกัน เฉพาะสถานะ `pending` และ `confirmed` ที่มีแถวในตารางนี้
- ใช้ `btree_gist` (`"roomId" WITH =`) เมื่อฐานข้อมูลมี extension นี้ (PostgreSQL ใน Docker มี) ส่วน PostgreSQL แบบ embedded ของ Serverpod ที่ใช้ตอนพัฒนา/ทดสอบไม่มี contrib จึงเทียบ `int8range(roomId, roomId, '[]')` แทน ซึ่งหมายถึง "ห้องเดียวกัน" เหมือนกัน

`tool/patch_migration.dart` ใส่ SQL นี้ลงใน `definition.sql` และ `migration.sql` และ server รัน SQL เดิมซ้ำตอนเริ่มทำงาน (idempotent)

### งานเบื้องหลัง

Future Call `MaintenanceCall` ทำงานทุก 1 นาที:

- คำขอที่ยังไม่อนุมัติเมื่อถึงเวลาเริ่ม → `expired` และคืนช่วงเวลา (SRS 2.4.3)
- การจองที่เลยเวลาสิ้นสุด → `completed`
- ส่งแจ้งเตือนก่อนเวลาเริ่มตามที่ผู้ใช้ตั้ง 5–60 นาที (SRS 2.5.1)
- ลบประวัติแจ้งเตือนที่เก่ากว่า 30 วัน (SRS 2.5.4)

## Deploy (Docker Compose)

```bash
cd deploy
cp .env.example .env          # ใส่รหัสผ่านและ PUBLIC_HOST
docker compose up -d --build  # PostgreSQL + Serverpod + backup รายวัน (เก็บ 7 วัน)
docker compose --profile tunnel up -d   # ถ้าต้องการเปิดผ่าน Cloudflare Tunnel
```

- ใช้ได้ทั้ง Raspberry Pi (arm64, RAM 4 GB ขึ้นไป) และ Cloud VPS โดยไม่ต้องแก้โค้ด
- Push Notification: วาง `firebase_service_account_key.json` ใน `deploy/secrets/`
- Backup อยู่ใน `deploy/backups/` (`pg_dump` บีบอัด)

## แพ็กเกจ client สำหรับแอป

`homeslot_client` ถูก generate จาก server และ commit ไว้ใน repo นี้ แอป Flutter อ้างอิงแพ็กเกจนี้แบบ path (`../homeslot-backend/homeslot_client`) ตอนพัฒนา หรือแบบ git dependency เมื่อแยกเครื่อง (ดู README ของ frontend)
