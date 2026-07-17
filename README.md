# Satu Dulu

Dokumentasi ini adalah blueprint pengembangan aplikasi iOS **Satu Dulu** menggunakan Flutter.

Satu Dulu adalah aplikasi focus, project, experiment, dan guide tracker untuk pengguna yang punya banyak ide/proyek tetapi sering kehilangan fokus, lupa tujuan, atau tidak konsisten menerbitkan hasil.

## Tujuan paket ini

Paket ini disusun agar bisa langsung dimasukkan ke root repository GitHub dan dipakai Codex sebagai konteks pembangunan aplikasi.

Isi paket mencakup:

- visi produk dan PRD;
- hierarki informasi dan alur pengguna;
- design system modern-minimalist white theme;
- spesifikasi seluruh layar utama;
- tracker proyek, sprint, daily action, dan metrik;
- PDF Library: import, rename, kategori, reader, bookmark, progress, dan catatan;
- backup ZIP lokal dan restore lengkap termasuk seluruh PDF;
- arsitektur Flutter dan struktur folder;
- database lokal dan data model;
- integrasi iOS, izin, file handling, serta notifikasi;
- rencana GitHub Actions untuk test dan build IPA;
- aturan keamanan dan privasi;
- test plan, acceptance criteria, roadmap, dan prompt siap pakai untuk Codex.

## Identitas produk

- **Nama aplikasi:** Satu Dulu
- **Tagline:** Banyak ide boleh. Hari ini tetap satu dulu.
- **Platform MVP:** iOS 16+
- **Framework:** Flutter
- **Penyimpanan:** Local-first
- **Backend MVP:** Tidak ada
- **Tema:** White, modern, minimalist, rounded, fluid
- **Bundle ID:** `com.kurogi.satudulu`
- **Repository:** `https://github.com/kuro-usagi-labs/satu-dulu`

## Menjalankan aplikasi

Prasyarat:

- Flutter stable;
- Xcode versi yang mendukung iOS 16+ untuk build iOS;
- CocoaPods untuk dependency native iOS.

Perintah pengembangan:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

### Preview di Windows

Flutter tidak menggunakan CSS/HTML untuk menyusun layar. Target web merender widget Dart yang sama dengan aplikasi iOS; `web/index.html` hanya menjadi loader.

```bash
flutter run -d chrome
```

Untuk menghasilkan preview statis yang dapat disajikan lewat server lokal:

```bash
flutter build web
cd build/web
python -m http.server 8080
```

Buka `http://localhost:8080`. Jangan membuka hasil build langsung dengan skema `file://` karena worker database memerlukan HTTP lokal.

Ikon aplikasi iOS/web dan mark launch screen dapat diregenerasi secara deterministik dari token brand:

```powershell
powershell -ExecutionPolicy Bypass -File tool/generate_app_icons.ps1
```

Pemeriksaan wajib sebelum membuka pull request:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Bundle ID aplikasi adalah `com.kurogi.satudulu`. Material signing tidak diperlukan untuk pemeriksaan pull request.

## Build IPA di GitHub

- Push ke `main` menjalankan format check, analyzer, dan seluruh test.
- Tag `v*` atau manual dispatch pada workflow **Build Unsigned iOS IPA** menghasilkan artefak `satu-dulu-unsigned-ipa` selama 14 hari.
- IPA unsigned harus ditandatangani ulang sebelum dipasang ke perangkat.
- Workflow **Build Signed iOS IPA** hanya dapat dijalankan manual dari environment terlindungi `ios-build` setelah seluruh secret signing Apple tersedia.

Detail signing dan troubleshooting ada di `docs/12_GITHUB_ACTIONS_IOS.md`.

## Urutan membaca

1. `AGENTS.md`
2. `PLANS.md`
3. `docs/INDEX.md`
4. `docs/01_PRODUCT_VISION.md`
5. `docs/02_PRD.md`
6. `docs/05_DESIGN_SYSTEM.md`
7. `docs/10_FLUTTER_ARCHITECTURE.md`
8. Dokumen fitur sesuai task yang sedang dikerjakan

## Prinsip utama

1. Pengguna hanya memiliki **satu fokus utama aktif**.
2. Aplikasi mengutamakan hasil yang benar-benar diterbitkan, bukan kesibukan semu.
3. Halaman Today harus tetap sederhana walau database pengguna kompleks.
4. PDF bukan lampiran pasif; PDF adalah panduan yang terhubung ke proyek dan bisa dibuka saat pengguna kehilangan arah.
5. Semua fungsi penting harus tetap berjalan offline.
6. Tampilan harus terasa seperti aplikasi iOS premium, bukan dashboard bisnis padat.

## Cara mulai dengan Codex

Berikan repository kepada Codex, lalu gunakan prompt dari folder `prompts/` secara berurutan. Jangan meminta seluruh aplikasi selesai dalam satu task besar.

Contoh:

```text
Baca AGENTS.md, PLANS.md, dan docs/INDEX.md. Kerjakan fase Bootstrap sesuai prompts/01_BOOTSTRAP.md. Jangan membangun fitur di luar scope fase tersebut. Jalankan formatter, analyzer, dan test sebelum selesai.
```

## Definition of done global

Sebuah task baru dianggap selesai bila:

- implementasi sesuai dokumen fitur;
- UI mengikuti design token;
- tidak ada error `flutter analyze`;
- test relevan lulus;
- loading, empty, error, dan success state ditangani;
- accessibility dasar tersedia;
- dokumentasi diubah jika ada keputusan baru;
- tidak ada secret atau credential masuk repository.
