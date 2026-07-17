# ExecPlan — Penutupan Siklus 30 Hari

Tanggal: 17 Juli 2026

## Objective

Menutup celah terbesar pada loop produk: ketika putaran 30 hari selesai,
pengguna dapat membaca bukti pada putaran tersebut lalu memilih **Lanjutkan**,
**Ubah pendekatan**, atau **Simpan dulu**. Keputusan harus benar-benar mengubah
status proyek dan sprint secara atomik, bukan hanya tersimpan sebagai jawaban
review.

## Product truth yang harus tetap terjaga

- Maksimal satu proyek berstatus `focus` dan satu berstatus `maintenance`.
- Review mingguan tetap menjadi refleksi mingguan dan tidak dipakai sebagai
  record penutupan siklus.
- Today tetap menampilkan satu hasil dan maksimal tiga tindakan.
- Putaran baru tidak menyalin daily plan atau action lama; setelah keputusan,
  pengguna menetapkan hasil hari baru secara sengaja.
- Pivot mengubah pendekatan pada sprint baru, bukan tujuan utama proyek.
- Park tidak diberi bahasa gagal dan tidak menghapus bukti lama.
- Seluruh fitur tetap local-first dan tidak menambah dependency produksi.
- Project Memory, Peta 30 Hari, Idea Inbox, dan backup/restore berada di luar
  scope perubahan ini.

## Diagnosis current state

1. Today mendeteksi tanggal review dari `projects.reviewDate`, lalu mengarahkan
   pengguna ke review mingguan.
2. Review mingguan hanya menyimpan jawaban; sprint tetap `active`, project tetap
   `focus`, dan tanggal review tidak bergerak.
3. Ringkasan Hasil membaca seluruh umur proyek walaupun copy menyebut
   `Putaran ini`.
4. Project yang lama berada di Parking Lot dapat memiliki sprint aktif yang
   sudah kedaluwarsa. Mengubah statusnya menjadi focus saja dapat membuat Today
   tidak punya konteks kerja.
5. Tidak ada record unik yang membuktikan bahwa sebuah sprint sudah ditutup,
   sehingga retry atau double tap berpotensi membuat putaran ganda.

## Keputusan arsitektur

### 1. Dedicated closure record

Schema v2 menambah tabel `sprint_closures`:

```text
id TEXT PRIMARY KEY
sprint_id TEXT NOT NULL UNIQUE REFERENCES sprints(id) ON DELETE CASCADE
decision TEXT NOT NULL
evidence_summary TEXT
next_approach TEXT
next_sprint_id TEXT UNIQUE REFERENCES sprints(id) ON DELETE SET NULL
replacement_project_id TEXT REFERENCES projects(id) ON DELETE SET NULL
closed_at INTEGER NOT NULL
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

Nilai `decision` memakai nama enum stabil `continueFocus`, `pivot`, atau `park`.
Constraint unik pada `sprint_id` membuat satu sprint hanya dapat ditutup sekali.
`weekly_reviews` tidak diubah.

### 2. Satu transaksi lifecycle

`TrackerRepository.closeCycle()` menjalankan seluruh transisi dalam satu
transaction:

- validasi project masih focus, sprint milik project, sprint masih active, dan
  belum memiliki closure;
- ubah sprint lama menjadi `completed`;
- Continue/Pivot membuat tepat satu sprint aktif baru selama 30 hari;
- update `projects.reviewDate` ke akhir sprint baru;
- Park mengubah project lama menjadi `parkingLot`;
- bila replacement dipilih, batalkan sprint aktif lama milik replacement,
  jadikan replacement sebagai focus, lalu mulai putaran 30 hari baru;
- insert closure setelah seluruh ID tujuan diketahui;
- verifikasi akhir maksimal satu focus dan satu sprint aktif pada focus.

Kegagalan di langkah mana pun harus me-rollback seluruh perubahan.

### 3. Tidak ada rollover debt

Continue, Pivot, dan replacement focus membuat sprint baru tetapi tidak membuat
daily plan. Setelah kembali ke Today, CTA `Tentukan hasil hari ini` membuat plan
baru. Action lama tetap menjadi histori pada sprint yang ditutup.

### 4. Dedicated cycle review UI

Route baru:

```text
/projects/:projectId/cycle-review
```

Screen dibuat compact dan scrollable:

1. identitas proyek dan rentang putaran;
2. snapshot bukti yang dibatasi tanggal sprint;
3. pilihan Continue / Pivot / Park;
4. area kondisional;
5. sticky commit CTA.

Continue tidak membutuhkan input tambahan. Pivot mewajibkan satu `Pendekatan
baru`. Park menampilkan calon fokus pengganti dan pilihan eksplisit `Belum pilih
sekarang`. Project current dan archived tidak boleh muncul sebagai kandidat.

Setelah sukses:

- Continue/Pivot → Today, yang meminta hasil hari pertama;
- Park + replacement → Today untuk fokus baru;
- Park tanpa replacement → Proyek, dengan recovery untuk memilih atau membuat
  fokus.

Review mingguan tetap memakai `/results/review?project=...`.

### 5. Sprint-scoped evidence

Results repository menerima rentang tanggal opsional. Layar cycle review selalu
mengirim `sprint.startDate...sprint.endDate`. Ringkasan utama Hasil memakai sprint
aktif atau sprint terbaru agar label `Putaran ini` sesuai dengan data yang
ditampilkan.

## Implementation phases

1. **Schema and domain** — table v2, migration, enum, input/result/snapshot model,
   dan generated Drift artifacts.
2. **Atomic repository** — query reviewable sprint, latest sprint, close-cycle
   transaction, replacement handling, dan range-filtered summary.
3. **Presentation** — providers/controller, dedicated route/screen, Today due CTA,
   dan affordance Hasil.
4. **Proof** — migration, repository, widget, navigation, full regression, web
   build, dan visual QA compact/Dynamic Type.

## Validation

- Migration v1 → v2 mempertahankan project, sprint, plan, ship, metric, weekly
  review, guide, dan notification preferences.
- `sprint_closures` tersedia, kosong setelah migration, FK aktif, dan duplicate
  closure ditolak.
- Continue menutup sprint lama, membuat satu sprint baru, dan memindahkan
  `reviewDate`.
- Pivot kosong ditolak tanpa perubahan data; Pivot valid menyimpan pendekatan
  pada hypothesis sprint baru tanpa mengubah `Project.shortGoal`.
- Park tanpa replacement menghasilkan state tanpa focus yang recoverable.
- Park dengan replacement menyisakan tepat satu focus dan satu sprint aktif yang
  mencakup tanggal mulai baru.
- Retry/double submit tidak membuat closure atau sprint tambahan.
- Bukti cycle review tidak memasukkan metric dari luar rentang sprint.
- Today membuka route cycle review khusus dan tidak lagi memakai weekly review
  untuk siklus selesai.
- Layout keputusan tidak overflow pada 320×640 dan text scale 1,3.
- `dart format --output=none --set-exit-if-changed .`
- `flutter analyze --no-pub`
- `flutter test --no-pub --concurrency=1`
- `flutter build web --release --no-pub`
- visual QA web untuk Continue, Pivot, Park, zero evidence, dan no replacement.

## Risks and mitigations

- **Dua sprint aktif akibat retry:** transaction, reread state, dan unique closure
  membuat submit kedua ditolak deterministik.
- **Replacement menjadi focus tetapi Today mati:** replacement selalu mendapat
  sprint baru yang mencakup tanggal keputusan; sprint aktif lamanya dibatalkan.
- **Data v1 hilang saat upgrade:** migration hanya menambah tabel; fixture v1
  tidak diubah dan migration test memverifikasi record existing.
- **Weekly review berubah makna:** route, table, provider, dan UI weekly tetap
  terpisah.
- **Today berubah menjadi dashboard:** bukti lengkap hanya berada pada cycle
  review; Today tetap menunjukkan satu CTA untuk keputusan atau pekerjaan hari
  ini.

## Rollback

Schema v2 bersifat add-only. Rollback kode dapat menghentikan pemakaian route dan
repository baru tanpa mengubah tabel lama. Aplikasi yang sudah membuka schema v2
tidak boleh dipaksa kembali ke binary schema v1; untuk source rollback, tetap
pertahankan `schemaVersion = 2` dan table declaration sampai migration penerus
tersedia.

## Progress

- [x] Audit product contract, schema, repository, dan UI
- [x] Putuskan boundary weekly review vs cycle closure
- [x] Schema v2 dan migration
- [x] Atomic lifecycle repository
- [x] Dedicated cycle review UI
- [x] Automated regression dan visual QA

## Completion evidence

- `dart format --output=none --set-exit-if-changed .` memeriksa 91 file tanpa
  perubahan tersisa.
- `flutter analyze --no-pub` selesai tanpa issue.
- `flutter test --no-pub --concurrency=1` lulus 55/55, termasuk migration v1 →
  v2, transaksi Continue/Pivot/Park, duplicate retry, no-rollover, date-range
  evidence, dan widget flow pada 320×640/text scale 1,3.
- `flutter build web --release --no-pub` berhasil dan WASM dry run lulus.
- `tool/visual_qa.py` menjalankan alur aplikasi nyata lalu memajukan waktu
  browser 31 hari untuk memotret due state, sprint evidence, decision cards,
  Pivot, dan Park tanpa browser error.
- Generated migration mencakup `drift_schema_v2.json`, `schema_v2.dart`, dan
  helper multi-version. Fixture schema v1 tidak diubah secara semantik.

Build/launch native iOS dan pemeriksaan Dynamic Type pada perangkat fisik tetap
menjadi release gate di runner macOS/iPhone.
