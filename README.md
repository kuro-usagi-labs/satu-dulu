# Satu Dulu

[![Flutter CI](https://github.com/kuro-usagi-labs/satu-dulu/actions/workflows/ci.yml/badge.svg)](https://github.com/kuro-usagi-labs/satu-dulu/actions/workflows/ci.yml)
[![Latest release](https://img.shields.io/github/v/release/kuro-usagi-labs/satu-dulu)](https://github.com/kuro-usagi-labs/satu-dulu/releases/latest)

**Banyak ide boleh. Hari ini tetap satu dulu.**

Satu Dulu adalah aplikasi iOS local-first untuk memilih satu fokus, menjalankan
eksperimen 30 hari, menyelesaikan hasil harian, mencatat bukti, dan kembali ke
arah semula ketika kehilangan fokus. Seluruh fungsi utama bekerja offline tanpa
akun, backend, atau cloud sync.

## Fitur utama

- Satu project berstatus fokus dan maksimal satu project maintenance.
- Siklus eksperimen 30 hari tanpa membawa tugas basi ke hari atau siklus baru.
- Today dengan satu hasil wajib dan maksimal tiga tindakan.
- **Ship Hari Ini** untuk menyimpan hasil, bukti, dan metrik harian.
- Low-energy mode yang memperkecil tindakan tanpa menghapus tujuan.
- Idea Inbox, Restart Capsule, daily check-in, dan Recovery Mode.
- Weekly review terpisah dari penutupan siklus 30 hari.
- Project archive yang tetap dapat ditemukan dan diaktifkan kembali.
- Library PDF offline dengan import, reader, resume halaman, bookmark, dan catatan.
- Pengingat lokal yang mengikuti zona waktu perangkat.
- Backup dan restore ZIP lokal, termasuk database dan seluruh PDF.

## Status

Versi stabil terbaru: **1.2.2**.

- Platform utama: iOS 16+
- Framework: Flutter
- State management: Riverpod
- Navigation: go_router
- Database: Drift + SQLite
- PDF reader: pdfrx
- Penyimpanan: lokal pada perangkat
- Bundle ID: `com.kurogi.satudulu`

Repository tidak menyimpan certificate, provisioning profile, secret signing,
atau data pengguna. Karena tidak ada cloud sync, pengguna perlu membuat backup
ZIP secara berkala sebelum mengganti atau mereset perangkat.

## Menjalankan aplikasi

Prasyarat:

- Flutter stable;
- Xcode yang mendukung iOS 16+;
- CocoaPods untuk dependency native iOS.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Pemeriksaan wajib sebelum perubahan digabungkan:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

## Build dan distribusi iOS

- Push ke `main` menjalankan format check, analyzer, dan seluruh test.
- Tag `v*` menjalankan workflow **Build Unsigned iOS IPA**.
- IPA unsigned harus ditandatangani ulang sebelum dipasang ke perangkat.
- Workflow **Build Signed iOS IPA** dijalankan manual melalui environment
  terlindungi `ios-build` setelah secret Apple tersedia.

Petunjuk lengkap tersedia di
[`docs/12_GITHUB_ACTIONS_IOS.md`](docs/12_GITHUB_ACTIONS_IOS.md).

## Preview web

Target web digunakan untuk QA visual terhadap widget Flutter yang sama dengan
aplikasi iOS.

```bash
flutter run -d chrome
```

Atau buat hasil statis dan sajikan melalui HTTP lokal:

```bash
flutter build web
cd build/web
python -m http.server 8080
```

Jangan membuka `build/web/index.html` langsung melalui `file://` karena worker
database memerlukan HTTP lokal.

## Struktur dokumentasi

Mulai dari:

1. [`AGENTS.md`](AGENTS.md)
2. [`PLANS.md`](PLANS.md)
3. [`docs/INDEX.md`](docs/INDEX.md)
4. Dokumen fitur yang terkait dengan perubahan

Prinsip produk, arsitektur, skema database, aturan UI, strategi backup, serta
prosedur signing iOS didokumentasikan di folder [`docs`](docs/INDEX.md).

## Prinsip produk

1. Hanya satu fokus utama yang aktif.
2. Today tetap ringkas dan tidak berubah menjadi daftar tugas panjang.
3. Hasil yang benar-benar diterbitkan lebih penting daripada kesibukan semu.
4. PDF tetap dapat dibaca secara offline ketika pengguna kehilangan arah.
5. Tidak ada gamifikasi yang mempermalukan atau menekan pengguna.
6. Data tetap milik pengguna dan dapat dipindahkan melalui backup lokal.
