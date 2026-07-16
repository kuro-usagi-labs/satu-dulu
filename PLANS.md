# PLANS.md — Execution Plan

Dokumen ini mendefinisikan fase pembangunan. Codex harus menyelesaikan satu fase secara vertikal sebelum memperluas scope.

## Phase 0 — Repository bootstrap

Tujuan: repository Flutter bersih, bisa dianalisis dan dites.

Deliverables:

- Flutter app scaffold;
- package name dan bundle ID placeholder;
- theme foundation;
- router kosong dengan shell navigation;
- Riverpod setup;
- Drift database bootstrap;
- folder architecture;
- CI lint/test awal;
- README run instructions.

Exit criteria:

- app membuka shell empat tab;
- `flutter analyze` bersih;
- test template lulus;
- no signing diperlukan untuk PR checks.

## Phase 1 — Core project tracking

Deliverables:

- onboarding singkat;
- create/edit project;
- project status: focus, maintenance, parkingLot;
- aturan hanya satu focus;
- sprint 30 hari;
- daily actions maksimal tiga;
- Today dashboard;
- Ship action;
- low energy mode.

Exit criteria:

- pengguna bisa membuat focus project dan menyelesaikan satu hari;
- restart app tidak menghilangkan data;
- aturan domain memiliki unit test.

## Phase 2 — Lost Track recovery

Deliverables:

- tombol Aku Lupa Arah;
- rangkuman tujuan, alasan, target hari ini;
- tindakan terkecil berikutnya;
- link ke guide utama bila tersedia;
- empty state yang membantu.

Exit criteria:

- recovery flow bisa dibuka maksimal dua tap dari Today;
- tidak menampilkan seluruh backlog.

## Phase 3 — PDF Library MVP

Deliverables:

- import PDF dari Files;
- copy ke application documents;
- metadata database;
- rename display title;
- assign project/category;
- pin;
- search metadata;
- list/grid;
- open PDF offline;
- remember last page;
- delete document.

Exit criteria:

- file tetap tersedia setelah restart;
- rename tidak mengubah file path;
- invalid/corrupt file menampilkan error yang jelas.

## Phase 4 — PDF reading enhancements

Deliverables:

- page thumbnails;
- bookmark page;
- notes per page;
- progress percentage;
- continue reading card;
- direct open to linked page.

## Phase 5 — Metrics and weekly review

Deliverables:

- daily metric entry;
- content/upload, views, clicks, orders, revenue, work minutes;
- weekly review;
- simple result cards;
- project comparison without misleading conclusions.

## Phase 6 — Notifications and polish

Deliverables:

- local notifications;
- reminder preferences;
- smooth transitions;
- haptics;
- accessibility pass;
- empty/error/loading states;
- performance pass.

## Phase 7 — GitHub Actions IPA

Deliverables:

- PR CI workflow;
- unsigned IPA workflow for re-signing/sideload tooling;
- optional signed IPA workflow;
- artifact naming;
- signing setup documentation;
- no credentials in repository.

## Phase 8 — Release candidate

Deliverables:

- full regression test;
- database migration test;
- privacy copy;
- app icon and launch screen placeholder replacement;
- release notes;
- tagged IPA artifact.

## ExecPlan rule

Buat dokumen rencana task khusus bila pekerjaan:

- menyentuh lebih dari tiga feature module;
- memerlukan migration data;
- mengubah navigation architecture;
- mengubah signing atau CI;
- diperkirakan membutuhkan beberapa sesi kerja.

Rencana task harus memuat tujuan, batasan, langkah implementasi, validasi, risiko, dan rollback.
