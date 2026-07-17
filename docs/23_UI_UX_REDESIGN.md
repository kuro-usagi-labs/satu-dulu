# ExecPlan — Guided calm-editorial redesign

Tanggal: 17 Juli 2026

## Objective

Merombak pengalaman Satu Dulu agar pengguna baru segera memahami fungsi produk,
tahu harus memulai dari mana, dan dapat bergerak melalui alur harian tanpa harus
menafsirkan istilah atau struktur aplikasi sendiri. Perombakan mencakup design
tokens, komponen inti, onboarding, navigation shell, layar utama, form penting,
empty/loading/error states, microcopy, serta hubungan antara Ship dan bukti hasil.

## Product truth yang harus tetap terjaga

- Satu proyek saja berstatus `focus` dan maksimal satu berstatus `maintenance`.
- Today tetap berisi satu hasil wajib dan maksimal tiga tindakan.
- CTA hasil harian tetap memakai istilah **Ship Hari Ini**.
- Mode energi rendah mengecilkan langkah tanpa menghapus arah atau memberi rasa
  bersalah.
- PDF tetap local-first, dapat dibaca offline, dan terhubung ke konteks proyek.
- Primary navigation tetap memiliki empat ruang: Hari Ini, Proyek, Panduan, Hasil.
- Tidak menambah backend, akun, AI, cloud sync, atau dependency produksi baru.

## Diagnosis current state

1. First launch hanya menjelaskan janji lalu langsung membuka form proyek panjang.
   Pengguna belum mengetahui cara kerja harian atau fungsi empat tab.
2. Istilah fokus, eksperimen, sprint, outcome, action, Ship, guide, dan result
   muncul hampir bersamaan tanpa progressive disclosure.
3. Today menampilkan semua komponen sebagai kumpulan kartu dengan bobot visual
   mirip. Langkah pertama yang harus dikerjakan tidak cukup menonjol.
4. Aksi Ship berhenti pada snackbar; hubungan berikutnya ke pencatatan bukti dan
   review tidak terlihat.
5. Focus, Maintenance, dan Parking Lot memakai istilah internal sebagai judul UI
   tanpa penjelasan tugas masing-masing.
6. Panduan tampak seperti file manager PDF, bukan alat untuk kembali bekerja saat
   kehilangan arah.
7. Hasil tampak seperti dashboard metrik generik sebelum menjelaskan keputusan
   apa yang dapat dibantu oleh datanya.
8. Palette biru-putih, outline pada hampir semua kartu, radius seragam, spinner,
   dan layout section yang berulang membuat produk terasa generik dan kaku.

## UX north star

Pengguna selalu dapat menjawab tiga pertanyaan tanpa berpindah konteks:

1. **Apa satu hal yang sedang saya kejar?**
2. **Apa langkah konkret berikutnya?**
3. **Setelah selesai, di mana saya mencatat buktinya?**

Alur utama yang ditampilkan secara konsisten:

```text
Pilih satu fokus
→ tetapkan satu hasil hari ini
→ kerjakan langkah berikutnya (maksimal tiga)
→ Ship Hari Ini
→ catat bukti/angka bila ada
→ review untuk lanjut, pivot, atau simpan dulu
```

## Information architecture dan language system

Empat tab dipertahankan, tetapi setiap ruang diberi fungsi satu kalimat:

- **Hari Ini** — tempat memulai dan menyelesaikan satu hasil.
- **Proyek** — tempat memilih fokus dan menyimpan ide lain tanpa mengganggu Today.
- **Panduan** — bahan rujukan yang dibuka ketika macet, bukan koleksi pasif.
- **Hasil** — bukti untuk mengambil keputusan, bukan papan skor yang menghakimi.

Istilah teknis disederhanakan pada UI:

- `focus` → **Fokus utama**;
- `maintenance` → **Tetap dijaga**;
- `parkingLot` → **Disimpan dulu**;
- sprint → **putaran/fokus 30 hari** pada copy penjelas;
- metric entry → **catat bukti** pada CTA, sementara label angka tetap spesifik.

## First-use flow baru

```text
Promise
→ lihat pola kerja Pilih / Kerjakan / Ship
→ kenali fungsi empat ruang
→ setup fokus dalam tiga langkah
   1. Pilih proyek dan alasan sekarang
   2. Tentukan bukti 30 hari dan hasil hari pertama
   3. Pecah menjadi maksimal tiga langkah + versi energi rendah
→ Today menyorot langkah pertama
```

## Daily flow baru

```text
Open Today
→ baca satu hasil wajib
→ mulai dari tindakan incomplete pertama yang ditonjolkan
→ centang tindakan berikutnya
→ Ship Hari Ini
→ confirmation sheet
   ├─ output Ship otomatis masuk Hasil
   ├─ Catat bukti sekarang → lengkapi angka di metric entry
   └─ Selesai untuk hari ini → kembali ke Today
```

Jika belum ada rencana hari ini, Today menjelaskan bahwa hari baru tidak membawa
utang tugas dan menawarkan satu CTA untuk menyusun hasil hari ini.

## Recovery flow baru

```text
Today → Aku Lupa Arah
→ ingat kembali tujuan + alasan memilih proyek
→ lihat satu tindakan terkecil
→ Kerjakan sekarang
└─ bila perlu, Buka panduan arah
```

Konten recovery memakai progressive disclosure dan tidak menampilkan backlog atau
analytics penuh.

## Visual direction

Nama arah: **calm editorial focus**.

- Canvas warm paper, surface porcelain, teks ink kehijauan gelap.
- Satu aksen terracotta sebagai penanda fokus dan primary action.
- Semantic success/warning/danger tetap tersedia dengan saturasi rendah.
- Typography memakai system font iOS dengan display lebih tegas, tracking rapat,
  dan body yang lapang.
- Radius bervariasi: control kecil, card medium, hero lebih lunak.
- Border tidak lagi membungkus semua hal; hierarchy dibuat lewat warna surface,
  whitespace, rail/marker, dan tinted shadow yang tipis.
- Layout lebih asimetris: eyebrow, angka langkah, rail vertikal, serta hero dengan
  metadata yang tidak disusun sebagai dashboard kartu seragam.
- Motion hanya menjelaskan perubahan: page onboarding, low-energy morph, action
  completion, Ship confirmation, dan tab feedback; Reduce Motion tetap dihormati.

## Implementation phases

1. **Foundation** — ganti semantic palette, typography, component themes,
   navigation dock, screen frame, skeleton/empty/section/step primitives.
2. **Understand** — onboarding tiga bagian dan setup fokus bertahap.
3. **Act** — Today, daily plan, low energy, recovery, dan Ship-to-evidence handoff.
4. **Organize** — Proyek serta detail proyek dengan bahasa status yang jelas.
5. **Learn** — Panduan, detail PDF, Hasil, metric entry, weekly review, settings,
   dan form pendukung memakai hierarchy baru.
6. **Prove** — widget tests alur baru, format, analyze, full test, web build, dan
   visual QA pada viewport iPhone kecil/standar melalui preview web.

## Validation

- `dart format --output=none --set-exit-if-changed .`
- `flutter analyze`
- `flutter test --concurrency=1`
- `flutter build web --release`
- Widget tests membuktikan onboarding menjelaskan alur dan empat ruang.
- Widget tests membuktikan Today menonjolkan satu outcome, maksimal tiga action,
  low-energy recovery, dan handoff Ship ke pencatatan bukti.
- Visual QA pada lebar 320–430 px, text scale wajar, empty/data/error state utama.
- Tidak ada hex warna baru di luar token theme.
- Audit akhir memeriksa seluruh presentation screen, bukan hanya empat tab utama.

## Risks and mitigations

- **Perombakan lintas layar merusak behavior:** repository/domain tidak diubah;
  refactor dibatasi pada presentation dan dilindungi test existing + test baru.
- **Layout overflow pada iPhone kecil/Dynamic Type:** hindari row berisi copy panjang,
  gunakan Wrap/Flexible, scrollable forms, dan uji viewport kecil.
- **Terminologi baru tidak sinkron dengan domain:** enum/database tetap sama;
  mapping label hanya berada di presentation layer.
- **Visual terlalu dekoratif:** satu accent, white-theme guardrail, dan motion
  fungsional tetap menjadi batas.
- **Build iOS tidak tersedia di Windows:** gunakan Flutter web untuk visual QA dan
  pertahankan macOS/iPhone sebagai release gate yang terdokumentasi.

## Rollback

Perubahan tidak menyentuh schema atau data. Rollback dapat dilakukan per fase pada
presentation layer. Domain, repository, file service, dan migration dipertahankan.

## Progress

- [x] Foundation
- [x] Understand
- [x] Act
- [x] Organize
- [x] Learn
- [x] Prove

## Completion evidence

- `dart format .` dijalankan pada seluruh source dan test.
- `flutter analyze` selesai tanpa issue.
- `flutter test --concurrency=1` lulus `32/32`, termasuk onboarding dan setup
  fokus pada `320×640`/text scale `1.3`, empat tab utama pada ukuran yang sama,
  recovery tanpa action, route invalid, Ship-to-metric, dan product guardrails.
- `flutter build web --release` berhasil; WASM dry run juga berhasil.
- `tool/visual_qa.py` menjalankan alur first use nyata dan menghasilkan 13
  screenshot untuk onboarding, setup tiga langkah, Today, Proyek, Panduan,
  Hasil, serta compact `320 px`, tanpa browser error.
- Audit kontras memverifikasi inverse/accent `4,96:1`, tertiary/canvas `4,63:1`,
  danger/danger-soft `5,06:1`, dan batas control minimal `3:1`.
- Audit source tidak menemukan literal warna presentasi di luar token theme,
  mojibake, whitespace error, dependency produksi baru, atau perubahan schema.

Validasi native iOS dan Dynamic Type pada perangkat fisik tetap menjadi release
gate di macOS karena workspace pengembangan ini berjalan di Windows.
