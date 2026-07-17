# ExecPlan — Satu Dulu v1.2 Anti-lupa

## Status

- Branch: `codex/anti-lupa-v1.2.0`
- Tracking issue: #4
- Target version: `1.2.0`
- Scope: local-first, offline, iOS-first, tanpa AI/network

## Tujuan

Versi 1.2 mengubah Satu Dulu dari tracker yang menunggu input menjadi sistem yang membantu pengguna:

1. menangkap ide tanpa menjadikannya proyek aktif;
2. mengingat konteks proyek yang berhenti;
3. membuat rencana sesuai energi dan waktu nyata;
4. mendeteksi kehilangan ritme tanpa menyalahkan pengguna;
5. mengubah review mingguan menjadi keputusan yang benar-benar diterapkan.

Kelima fitur harus membentuk satu loop:

```text
Idea Inbox
  → convert menjadi proyek tersimpan
  → aktifkan sebagai fokus
  → Daily Check-in
  → Today plan yang realistis
  → Recovery Mode bila ritme jatuh
  → Weekly Review
  → continue / pivot / park
  → Restart Capsule diperbarui
```

## Prinsip produk

- Idea bukan project. Menangkap ide tidak boleh membuat sprint atau mengambil ruang Today.
- Today tetap sederhana: satu hasil, maksimal tiga tindakan.
- Recovery menggunakan bukti perilaku lokal, bukan rasa bersalah atau streak.
- Restart Capsule menyimpan konteks untuk kembali, bukan backlog panjang.
- Review hanya menerapkan keputusan setelah konfirmasi eksplisit.
- Semua perubahan status, sprint, review, dan capsule dilakukan secara transaksional.
- Tidak ada chatbot, OCR, cloud sync, login, atau analytics pihak ketiga.

## Arsitektur

Tambahkan feature module baru:

```text
lib/features/anti_forget/
├── data/repositories/drift_anti_forget_repository.dart
├── domain/entities/anti_forget_models.dart
├── domain/repositories/anti_forget_repository.dart
└── presentation/
    ├── controllers/anti_forget_providers.dart
    ├── screens/idea_inbox_screen.dart
    ├── screens/daily_check_in_screen.dart
    ├── screens/restart_capsule_screen.dart
    └── widgets/anti_forget_widgets.dart
```

`ResultsRepository` tetap bertanggung jawab menyimpan review, tetapi operasi baru `saveAndApplyWeeklyReview` menjalankan review + perubahan project/sprint + Restart Capsule dalam satu transaction.

Recovery Mode dihitung oleh domain service murni dari:

- check-in hari ini;
- daily plan dan Ship hari ini;
- jumlah Ship tujuh hari terakhir;
- hari sejak Ship terakhir;
- status review;
- Restart Capsule proyek fokus.

## Data model v2

### ideas

```text
id TEXT PRIMARY KEY
title TEXT NOT NULL
note TEXT
source TEXT
disposition TEXT NOT NULL
converted_project_id TEXT
captured_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

Disposition:

```dart
enum IdeaDisposition { inbox, parked, discarded, converted }
```

### restart_capsules

Satu capsule per project.

```text
id TEXT PRIMARY KEY
project_id TEXT NOT NULL UNIQUE
last_known_state TEXT
last_output TEXT
what_worked TEXT
blocker TEXT
next_action TEXT
parked_reason TEXT
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

### daily_check_ins

Satu check-in per tanggal lokal.

```text
id TEXT PRIMARY KEY
check_in_date INTEGER NOT NULL UNIQUE
energy_level TEXT NOT NULL
available_minutes INTEGER NOT NULL
note TEXT
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

Energy:

```dart
enum EnergyLevel { low, normal, high }
```

Pilihan waktu UI: 10, 30, 60, 120 menit.

### weekly_reviews

Tambahkan:

```text
decision_applied_at INTEGER
```

Kolom ini mencegah keputusan diterapkan dua kali dan menjadi audit trail lokal.

## Alur fitur

### 1. Idea Inbox

Entry points:

- tombol `Tangkap ide` pada header Proyek;
- kartu ringkas di Proyek;
- route `/ideas`.

Capture hanya meminta judul. Note dan source opsional.

Actions:

- `Ubah jadi proyek`: membuat project `parkingLot` tanpa sprint aktif, membuat Restart Capsule awal, menandai idea `converted`;
- `Simpan`: disposition `parked`;
- `Buang`: disposition `discarded` dengan konfirmasi;
- edit judul/note.

Idea Inbox tidak menjadi tab kelima.

### 2. Restart Capsule

Ditampilkan pada detail proyek sebagai section `Lanjutkan tanpa mengingat semuanya`.

Capsule diperbarui saat:

- pengguna mengedit capsule manual;
- review memilih park;
- review memilih pivot;
- proyek fokus dipindahkan ke parking lot;
- proyek diaktifkan kembali.

Saat proyek parking lot menjadi focus, aplikasi:

1. membuat sprint 30 hari baru;
2. memakai `nextAction` capsule sebagai langkah pertama bila tersedia;
3. menampilkan capsule sekali pada Today sebagai context card;
4. tidak membawa completion lama.

### 3. Daily check-in

Today menampilkan check-in ringkas sebelum rencana dibuat. Bila belum ada check-in hari ini:

- Energi: rendah / normal / tinggi;
- Waktu: 10 / 30 / 60 / 120+ menit.

Check-in tidak memblokir Ship, tetapi digunakan untuk:

- menyarankan skala outcome;
- menyorot low-energy action;
- memilih copy Recovery Mode;
- memberi konteks pada Create Daily Plan.

Mapping dasar:

| Kondisi | Saran |
|---|---|
| low + 10/30 | satu langkah terkecil |
| normal + 30/60 | satu output kecil |
| high + 60/120 | outcome penuh, tetap maksimal tiga tindakan |

### 4. Recovery Mode otomatis

Recovery Mode muncul sebagai hero state pada Today bila salah satu kondisi terpenuhi:

- fokus aktif tetapi belum ada plan setelah pukul 12:00;
- dua hari atau lebih tanpa Ship;
- review due;
- check-in low dan plan terlalu besar;
- sprint aktif tidak sehat/tidak tersedia.

Severity:

```dart
enum RecoverySeverity { none, gentle, urgent }
```

Recovery Mode hanya menawarkan maksimal tiga actions:

- kerjakan tindakan terkecil;
- buka guide/capsule;
- kecilkan atau buat plan hari ini.

Tidak ada copy yang menghukum, streak merah, atau backlog kemarin.

### 5. Weekly review menerapkan keputusan

Setelah form review, tampilkan confirmation sheet berisi efek nyata.

#### Continue

- simpan review;
- tandai keputusan applied;
- jika sprint berakhir dalam tujuh hari, buat sprint baru;
- gunakan `nextWeekFocus` untuk outcome/template awal;
- status project tetap focus.

#### Pivot

- simpan review;
- simpan pendekatan lama ke Restart Capsule;
- tutup sprint aktif sebagai completed;
- buat sprint 30 hari baru;
- gunakan `nextWeekFocus` sebagai hypothesis dan template outcome;
- status project tetap focus.

#### Park

- wajib isi satu konteks penutup/next action;
- simpan review;
- perbarui Restart Capsule;
- batalkan sprint aktif;
- pindahkan project ke parkingLot;
- Today kembali ke empty state untuk memilih fokus berikutnya.

Operasi harus idempotent: review yang sudah memiliki `decisionAppliedAt` tidak boleh diterapkan lagi.

## Navigation

Tambahan route root:

```text
/ideas
/check-in
/projects/:projectId/restart
```

Tidak ada perubahan jumlah tab utama.

## Urutan implementasi

### Slice A — Schema dan domain

- schema v2;
- migration v1 → v2;
- models dan repository anti-forget;
- recovery evaluator murni;
- migration + repository tests.

### Slice B — Idea Inbox dan Restart Capsule

- routes;
- capture/edit/disposition/convert flow;
- project detail capsule;
- activation menggunakan capsule.

### Slice C — Daily Check-in dan Recovery

- check-in screen/sheet;
- provider Today context;
- Recovery Mode card;
- Create Daily Plan context/prefill.

### Slice D — Applied Weekly Review

- repository transaction;
- confirmation UI;
- continue/pivot/park behavior;
- invalidation dan navigation.

### Slice E — Polish dan regression

- empty/loading/error/success states;
- accessibility labels;
- compact iPhone layout;
- formatter, analyzer, tests;
- changelog dan version bump.

## Acceptance criteria

- Menangkap idea membutuhkan maksimal dua taps dari Proyek.
- Idea baru tidak membuat project atau sprint.
- Convert idea selalu menghasilkan project parking lot dan capsule.
- Check-in tersimpan untuk satu tanggal lokal dan dapat diedit.
- Recovery evaluator memiliki unit test untuk semua trigger.
- Recovery UI tidak menampilkan lebih dari tiga tindakan.
- Reactivate project memakai next action dari capsule bila ada.
- Continue, pivot, dan park review memiliki repository test.
- Decision tidak dapat diterapkan dua kali.
- Migration v1 → v2 mempertahankan project, sprint, plan, Ship, metric, PDF, dan setting.
- Tidak ada dependency produksi baru kecuali keputusan tertulis terpisah.

## Risiko

### Risiko: review mengubah data secara parsial

Mitigasi: satu Drift transaction untuk review, project, sprint, plan, dan capsule.

### Risiko: Recovery Mode terlalu sering muncul

Mitigasi: evaluator deterministik, severity bertingkat, dan trigger terdokumentasi/testable.

### Risiko: Idea Inbox menjadi backlog baru

Mitigasi: hanya inbox aktif yang tampil utama; converted/discarded disembunyikan; weekly cleanup bukan notifikasi memaksa.

### Risiko: migration gagal

Mitigasi: additive schema, migration test dari schema v1, tanpa drop/rename kolom.

## Rollback

- PR tidak di-merge sebelum migration, analyze, dan test lulus.
- Schema v2 hanya additive; rollback kode ke v1 tidak boleh dilakukan pada database yang sudah migrasi.
- Bila masalah ditemukan sebelum release, perbaiki forward melalui schema v3 atau patch v1.2.x, bukan downgrade database.
