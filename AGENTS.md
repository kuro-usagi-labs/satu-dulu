# AGENTS.md — Satu Dulu

## Mission

Bangun aplikasi iOS Flutter bernama **Satu Dulu** yang membantu pengguna memilih satu fokus, menjalankan eksperimen 30 hari, menerbitkan hasil harian, menyimpan metrik, dan membuka PDF panduan ketika kehilangan arah.

## Read before working

Sebelum mengubah kode:

1. Baca `README.md`.
2. Baca `PLANS.md`.
3. Baca `docs/INDEX.md`.
4. Baca dokumen fitur yang terkait task.
5. Pastikan task berada dalam fase roadmap aktif.

## Product guardrails

- Hanya satu project yang dapat berstatus `focus`.
- Maksimal satu project berstatus `maintenance` pada MVP.
- Project lain masuk `parkingLot`.
- Today screen tidak boleh berubah menjadi daftar tugas panjang.
- Maksimal tiga daily action tampil sekaligus.
- Tombol utama menggunakan istilah **Ship Hari Ini**.
- Jangan memakai gamifikasi yang mempermalukan pengguna.
- Jangan membuat streak sebagai sumber tekanan utama.
- Mode energi rendah harus memperkecil tindakan, bukan menghapus tujuan.
- PDF wajib tersimpan lokal dan tetap bisa dibaca offline.

## UI rules

- White theme dominan.
- Gunakan surface putih, background off-white, divider sangat lembut.
- Radius utama 20–24 px.
- Gunakan spacing berbasis kelipatan 4 dan 8.
- Animasi harus halus, singkat, dan memiliki tujuan.
- Jangan memakai gradient berlebihan, glassmorphism berat, neon, atau dark dashboard.
- Gunakan system font iOS melalui Flutter default typography kecuali ada keputusan baru.
- Semua screen harus diuji pada lebar kecil iPhone dan Dynamic Type yang wajar.

## Flutter rules

- Gunakan feature-first architecture.
- State management: Riverpod.
- Navigation: go_router.
- Local database: Drift + SQLite.
- PDF reader: pdfrx.
- File import: file_picker.
- File paths: path_provider.
- Notifications: flutter_local_notifications.
- Jangan menambah dependency produksi tanpa alasan yang ditulis pada PR atau decision log.
- Jangan menaruh business logic di Widget.
- Jangan memanggil database langsung dari presentation layer.
- Gunakan immutable model dan repository abstraction.
- Tulis migration untuk setiap perubahan schema setelah schema pertama dirilis.

## Coding standards

- Jalankan `dart format .`.
- Jalankan `flutter analyze`.
- Jalankan `flutter test`.
- Nama class/type dalam English; copy UI boleh Bahasa Indonesia.
- Hindari file lebih dari sekitar 400 baris; pecah bila tanggung jawab sudah bercampur.
- Gunakan komentar hanya untuk menjelaskan alasan, bukan mengulang kode.
- Tangani exception file dan database secara eksplisit.
- Gunakan UUID untuk identifier lokal.
- Simpan waktu dalam UTC; tampilkan dalam zona lokal.

## Testing expectations

- Unit test untuk domain rules dan repository.
- Widget test untuk screen penting.
- Integration test untuk alur onboarding, project focus, ship, dan PDF import/read.
- Gunakan fake repository untuk widget test.
- Jangan bergantung pada network di test MVP.

## Git and CI

- Jangan commit certificate, provisioning profile, password, API key, atau `.env` sensitif.
- Workflow PR harus menjalankan format check, analyze, dan test.
- Build iOS harus berjalan di runner macOS.
- Signed IPA hanya dibangun dari manual dispatch atau tag yang disengaja.
- Gunakan GitHub Actions Secrets untuk material signing.

## Scope control

Jangan membangun fitur berikut pada MVP kecuali diminta eksplisit:

- akun/login;
- cloud sync;
- kolaborasi tim;
- AI chat;
- OCR;
- full-text search isi semua PDF;
- subscription;
- Android-specific polish;
- social/community;
- marketplace.

## Completion report

Saat selesai task, laporkan:

1. Ringkasan perubahan.
2. File penting yang diubah.
3. Test yang dijalankan dan hasilnya.
4. Keputusan atau asumsi baru.
5. Risiko atau pekerjaan tersisa.
