# ExecPlan — Warm Editorial Redesign

Tanggal: 17 Juli 2026

## Objective

Mengintegrasikan keberanian visual referensi orange–black ke Satu Dulu tanpa
mengubah produk menjadi dashboard operasional. Redesign harus membuat tindakan,
bukti, recovery, dan status proyek terbaca dari peran warnanya sambil menjaga
Today tetap tenang dan berisi maksimal tiga tindakan.

## Batas perubahan

- Tidak mengubah schema, repository, atau business rule.
- Tidak mencampurkan Project Memory, Peta 30 Hari, Idea Inbox, atau backup.
- White theme tetap dominan.
- Near-black hanya dipakai untuk bukti/keputusan yang disengaja.
- Tidak menambah dependency produksi; ilustrasi dan chart vektor memakai
  `CustomPainter` agar ringan, offline, dan menghormati Reduce Motion.

## Semantic roles

| Peran | Token utama | Penggunaan |
|---|---|---|
| Tindakan | `action`, `actionSoft` | Fokus, Ship, CTA, pinned, data mark |
| Bukti/keputusan | `evidence`, `onEvidence` | Bukti utama dan keputusan review |
| Panduan | `guide`, `guideSoft` | Reader, resume, recovery |
| Berhasil/Maintenance | `success`, `maintenanceSoft` | Ship success, Tetap dijaga |
| Parking | `parking`, `parkingSoft` | Disimpan dulu |

Orange memakai near-black sebagai foreground. White pada orange tidak digunakan
untuk teks normal karena tidak memenuhi WCAG AA. Kombinasi semantic utama
dikunci oleh `test/design_system_test.dart`.

## Implementation phases

1. **Mockup** — kunci Hari Ini, Proyek, dan Hasil sebagai tiga layar terpisah.
2. **Foundation** — semantic palette, button, input, sheet, status pill, focus
   card, evidence card, press feedback, dan navigation indicator.
3. **Act** — Today, Ship, partial Ship, success, low energy, dan recovery.
4. **Organize** — hierarchy Fokus utama, Tetap dijaga, dan Disimpan dulu.
5. **Learn** — evidence card near-black, angka tabular, sparkline orange,
   review editorial, serta Panduan yang tetap white/orange.
6. **Understand** — onboarding dan empty state dengan satu bahasa stiker vektor.
7. **Prove** — Dynamic Type, Reduce Motion, contrast, touch target, full tests,
   web build, dan screenshot alur nyata.

## Motion and haptic policy

- press feedback 120 ms;
- small state change 210 ms;
- card entrance 280 ms;
- bottom sheet 340 ms masuk dan 280 ms keluar;
- vector sticker 560 ms satu kali;
- semua custom animation menjadi `Duration.zero` ketika Reduce Motion aktif;
- haptic hanya untuk Ship, perubahan fokus, dan commit keputusan review.

## Compact layout guardrails

- Empty state tidak memakai tinggi tetap atau spacer dekoratif.
- Ikon dan judul berbagi baris pertama; deskripsi memakai lebar penuh di bawah.
- Padding empty state 16 px, ikon 40 px, dan tinggi mengikuti isi.
- Pada lebar 320 px, empty state Hasil dijaga di bawah 200 px pada text scale
  normal dan tetap bebas overflow pada text scale 1,3.
- Bottom navigation tetap menampilkan empat label pada lebar 320 px.

## Validation

- `dart format --output=none --set-exit-if-changed .`
- `flutter analyze --no-pub`
- `flutter test --no-pub --concurrency=1`
- `flutter build web --release --no-pub`
- `python tool/visual_qa.py`
- visual inspection pada 390×844 dan 320×640;
- audit literal warna di luar `app_theme.dart`;
- audit Today tetap maksimal tiga tindakan dan bukan backlog.

## Progress

- [x] Mockup tiga layar utama
- [x] Semantic palette dan primitives
- [x] Today, Ship, Recovery, dan Low Energy
- [x] Proyek
- [x] Hasil
- [x] Panduan
- [x] Onboarding dan empty state
- [x] Motion/haptic audit akhir
- [x] Full regression dan visual QA akhir

## Validation evidence

- format check: 85 file, 0 perubahan;
- analyzer: tidak ada issue;
- test suite: 40 test lulus;
- web release build: lulus, termasuk WASM dry run;
- visual QA: alur onboarding sampai keputusan tersimpan lulus pada 390Ã—844;
- compact QA: Today, Proyek, Panduan, Hasil, onboarding, dan setup diperiksa
  pada 320Ã—640;
- haptic audit: tepat tiga event yang diizinkan;
- literal warna non-theme: tidak ditemukan;
- `git diff --check`: bersih.

## Rollback

Seluruh perubahan berada di presentation, theme, dokumentasi, dan test. Karena
schema/data tidak berubah, rollback dapat dilakukan per modul tanpa migrasi.
