# ExecPlan — Full Satu Dulu Application

## Objective

Membangun aplikasi Flutter iOS **Satu Dulu** secara vertikal hingga seluruh scope MVP pada `PLANS.md` dan acceptance criteria pada `docs/18_ACCEPTANCE_CRITERIA.md` terpenuhi.

## Constraints

- Ikuti product guardrails dan scope MVP pada `AGENTS.md`.
- Kerjakan fase sesuai urutan `PLANS.md`; jangan membawa fitur fase berikutnya ke fondasi tanpa kebutuhan arsitektural.
- Gunakan Riverpod, go_router, Drift/SQLite, pdfrx, file_picker, path_provider, dan flutter_local_notifications sesuai dokumen.
- Semua fungsi utama local-first dan test tidak bergantung jaringan.
- Tidak ada signing material atau secret di repository.

## Implementation phases

1. **Foundation** — scaffold Flutter, dependency minimum, semantic theme, stateful four-tab shell, database schema v1, CI, dan smoke/navigation tests.
2. **Usable tracker** — onboarding, project repository, one-focus transaction, sprint, daily plan/actions, Today, Ship, low-energy, dan Lost Track.
3. **Guides** — import/copy/validate PDF, metadata, search, detail, offline reader, resume page, delete, dan project linking.
4. **Evidence** — metric entry, result summaries, derived metrics, weekly review, dan decision flow.
5. **Personal polish** — local notifications, lifecycle handling, motion, haptics, accessibility, serta loading/empty/error states.
6. **Distribution** — PR CI, unsigned IPA, optional manual signed workflow, release documentation, dan final regression audit.

## Validation

Pada setiap fase:

- jalankan `dart format .`;
- jalankan `flutter analyze`;
- jalankan `flutter test`;
- tambahkan unit/widget/integration test sesuai `docs/14_TEST_PLAN.md`;
- periksa batas kecil iPhone, Dynamic Type, Reduce Motion, dan state offline yang relevan.

Final audit harus memetakan setiap item `docs/18_ACCEPTANCE_CRITERIA.md` ke implementasi dan bukti test/manual QA.

## Risks and mitigations

- **Flutter SDK tidak tersedia:** pasang/pakai SDK stable lokal dan catat versi yang dipakai.
- **Build iOS tidak dapat dijalankan di Windows:** validasi Dart/Flutter di Windows dan sediakan workflow macOS sebagai bukti build iOS.
- **Koordinasi file dan database PDF:** gunakan compensating cleanup dan uji jalur kegagalan.
- **Schema berubah setelah v1:** setiap perubahan memakai migration dan migration test; jangan menulis ulang migration yang sudah dirilis.
- **Scope melebar:** fitur deferred (AI, OCR, cloud, login, Android polish) tetap tidak dibangun.

## Rollback

- Setiap fase dibuat sebagai perubahan terfokus dan tidak menghapus dokumentasi sumber.
- Migration bersifat maju; rollback pengembangan dilakukan lewat perubahan kode baru, bukan mengubah riwayat migration yang sudah dirilis.
- Import PDF yang gagal menghapus file parsial dan tidak meninggalkan metadata.

## Progress

- [x] Foundation
- [x] Usable tracker
- [x] Guides
- [x] Evidence
- [x] Personal polish
- [ ] Distribution and final audit
