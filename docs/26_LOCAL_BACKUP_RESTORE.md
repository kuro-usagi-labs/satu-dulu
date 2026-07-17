# ExecPlan — Local backup and restore

## Objective

Menambahkan backup dan restore manual yang local-first dari Pengaturan. Satu
file backup harus dapat memulihkan proyek, putaran, rencana harian, Ship,
metrik, review, preferensi pengingat, metadata panduan, bookmark, catatan, dan
seluruh PDF lokal tanpa akun atau upload otomatis.

Fitur P1 ini dipromosikan sebagai pekerjaan kesiapan aplikasi setelah pemilik
produk meminta pengembangan dilanjutkan melampaui MVP dasar.

## Product constraints

- Backup hanya dibuat setelah tindakan eksplisit pengguna.
- File disimpan melalui document picker dan tidak pernah diunggah otomatis.
- Restore mengganti seluruh data saat ini dan selalu meminta konfirmasi.
- Backup penuh selalu menyertakan PDF agar metadata panduan tidak menunjuk file
  yang sengaja dihilangkan.
- `output/` di repository bukan bagian dari data aplikasi dan tidak disentuh.
- Preview web tetap menampilkan informasi fitur, tetapi operasi file hanya
  aktif pada build native.
- Tidak ada perubahan schema database untuk format backup pertama.

## Format decision

Gunakan ZIP dengan nama `satu-dulu-backup-YYYY-MM-DD-HHmmss.zip` dan struktur:

```text
manifest.json
data.json
pdfs/<document-uuid>.pdf
```

`manifest.json` memiliki format identifier, format version, schema database,
waktu UTC, checksum `data.json`, hitungan record, dan daftar PDF yang diurutkan
berdasarkan path lengkap dengan ukuran serta SHA-256. `data.json` menyimpan 12
tabel schema v2 dalam urutan deterministik. Dependency produksi `archive`
ditambahkan langsung dan dipin pada versi yang sudah dipakai secara transitif;
dependency ini dibutuhkan untuk ZIP offline lintas platform tanpa native SDK
tambahan.

SQLite mentah tidak disalin karena database dapat memakai WAL ketika aplikasi
berjalan dan penggantian file database memerlukan menutup serta membuat ulang
seluruh provider. Snapshot JSON memungkinkan validasi sebelum mutasi dan
restore atomik di dalam satu transaction Drift.

## Safety model

Sebelum menampilkan dialog konfirmasi restore:

1. batasi ukuran archive dan jumlah entry untuk mengurangi risiko ZIP bomb;
2. tolak path absolut, traversal, backslash, entry ganda, atau entry asing;
3. verifikasi format/version/schema dan checksum `data.json`;
4. verifikasi jumlah record terhadap manifest;
5. parse seluruh row memakai generated Drift data class;
6. validasi one-focus, one-maintenance, enum domain, action 0–2, dan invariant
   closure;
7. verifikasi setiap PDF terhadap path metadata, ukuran, SHA-256, dan header
   `%PDF-`.

Saat pengguna mengonfirmasi:

1. tulis semua PDF ke directory staging di Application Documents;
2. tukar directory PDF aktif dengan staging sambil menyimpan rollback copy;
3. ganti seluruh row database dalam satu transaction dengan delete/insert
   berurutan sesuai foreign key;
4. jika database gagal, kembalikan directory PDF lama;
5. setelah commit, bersihkan rollback copy dan jadwalkan ulang notification dari
   preferensi hasil restore.

Restore tidak mengubah data bila parsing, checksum, staging file, atau database
transaction gagal. Interupsi proses tepat di antara file swap dan database
commit masih menjadi risiko residual yang harus diuji pada perangkat; format
dan staging disusun agar recovery journal dapat ditambahkan tanpa mengubah
archive version.

## Implementation steps

1. Tambahkan model, repository abstraction, archive codec, dan file service
   native/stub untuk backup.
2. Implementasikan snapshot deterministik dan replacement transaction untuk
   seluruh tabel schema v2.
3. Implementasikan coordinator create, inspect, cancel, dan restore dengan
   compensating file rollback.
4. Tambahkan provider serta section compact pada Pengaturan dengan preview dan
   confirmation dialog.
5. Reschedule local notifications dan invalidate provider utama setelah restore.
6. Dokumentasikan format, privasi, batasan native, test plan, dan acceptance.

## Validation

- Unit test round-trip seluruh tabel.
- Unit test restore gagal menjaga database lama.
- Unit test archive checksum, entry asing/traversal, ukuran, dan PDF hilang.
- Coordinator test membuktikan file rollback ketika database gagal.
- Widget test create/cancel/confirm/error pada 320×640 dengan text scale 1,3.
- `dart format --output=none --set-exit-if-changed .`
- `flutter analyze --no-pub`
- `flutter test --no-pub --concurrency=1`
- `flutter build web --release` dan WASM dry run.
- Device gate: pilih/save dari Files, restore backup besar, low storage, dan
  paksa tutup ketika restore.

## Rollback

- Perubahan berada pada branch dan commit terpisah dari cycle closure.
- Format v1 bersifat add-only; implementasi masa depan tidak mengubah arti field
  yang sudah dirilis.
- Kegagalan sebelum database commit membuang staging dan mengaktifkan kembali
  directory PDF lama.
- Rollback source dilakukan lewat commit baru; riwayat schema v1/v2 tidak
  diubah.

## Progress

- [x] Audit storage, database lifecycle, Settings, dan file import.
- [x] Tetapkan format v1 dan strategi transaction/rollback.
- [x] Implementasikan data snapshot dan archive validation.
- [x] Implementasikan native file staging dan coordinator.
- [x] Implementasikan Settings UI dan notification refresh.
- [x] Tambahkan unit/widget tests.
- [x] Jalankan quality gates lokal dan compact widget QA.

## Completion evidence — 17 Juli 2026

- `dart format --output=none --set-exit-if-changed .` — 107 file, tidak ada
  perubahan.
- `flutter analyze --no-pub` — tidak ada issue.
- `flutter test --no-pub --concurrency=1` — 67/67 lulus.
- `flutter build web --release --no-pub` — berhasil; WASM dry run berhasil.
- Widget backup/restore lulus pada 320×640 dengan text scale 1,3.
- Save/open Files, low storage, dan force-close restore tetap menjadi gate
  perangkat iPhone.
