# Core Tracker Feature Specification

## Project statuses

```dart
enum ProjectStatus { focus, maintenance, parkingLot, archived }
```

Rules:

- maksimal satu `focus`;
- maksimal satu `maintenance` pada MVP;
- mengubah project menjadi focus harus memindahkan focus lama;
- archived tidak tampil di daftar utama;
- project tidak boleh dihapus permanen bila sudah punya metric/review tanpa confirmation khusus.

## Project fields

- name;
- shortGoal;
- whyChosen;
- successDefinition;
- targetRevenue optional;
- status;
- startDate;
- reviewDate;
- iconKey;
- accentKey;
- primaryGuideDocumentId optional.

## Sprint

Default 30 hari tetapi model mendukung custom duration.

Fields:

- projectId;
- title;
- hypothesis;
- startDate;
- endDate;
- targetOutputs;
- successCriteria;
- status.

## Daily plan

Setiap tanggal dapat memiliki:

- requiredOutcome;
- up to three actions;
- lowEnergyAction;
- optional linkedGuideId;
- optional linkedGuidePage;
- note.

Jika pengguna tidak menyelesaikan hari sebelumnya, action tidak otomatis ditambahkan ke hari baru.

## Ship record

Ship bukan sekadar semua checkbox selesai.

Fields:

- dailyPlanId;
- shippedAt;
- outputType;
- outputTitle;
- externalUrl optional;
- evidenceNote optional;
- isPartial;

Saat Ship disimpan, aplikasi secara atomik membuat atau memperbarui
`metric_entries` pada project dan tanggal yang sama dengan `outputs_count`
minimal `1`. Pengguna tetap bebas melewati pengisian angka respons; output yang
sudah dikirim tidak boleh hilang dari Hasil.

## Low energy mode

Behavior:

- pengguna menekan shortcut;
- aplikasi menampilkan lowEnergyAction yang sudah disiapkan;
- jika kosong, aplikasi menawarkan edit tindakan terkecil;
- original required outcome tetap terlihat sebagai konteks;
- completion dicatat sebagai partial ship bila memang hanya sebagian.

## Lost Track

Sumber data:

- active focus project;
- current sprint;
- today's daily plan;
- primary guide;
- recent ship status.

Fallback:

- no project → create focus;
- no sprint → create 30-day experiment;
- no today plan → create one outcome;
- no guide → continue without guide.

## Idea inbox — P1

Idea hanya memiliki:

- title;
- note;
- capturedAt;
- disposition: inbox, parkingLot, discarded, converted.

Menambahkan idea tidak membuat project aktif.

## Weekly decision

```dart
enum ReviewDecision { continueProject, pivotApproach, parkProject }
```

Decision tidak otomatis mengubah status tanpa confirmation.

## 30-day cycle closure

Penutupan siklus berbeda dari weekly decision. Satu sprint hanya dapat memiliki
satu closure final.

Behavior:

- Continue menyelesaikan sprint lama dan membuat sprint 30 hari baru;
- Pivot mewajibkan pendekatan baru pada `Sprint.hypothesis`, sementara goal
  project tetap;
- Park menyelesaikan sprint lama, memindahkan project ke Parking Lot, dan
  menawarkan focus pengganti;
- memilih replacement membatalkan sprint aktif lamanya yang stale lalu membuat
  putaran baru yang mencakup tanggal keputusan;
- putaran baru tidak menyalin daily plan atau daily action lama;
- retry atau double submit tidak boleh membuat sprint kedua.

Seluruh perubahan status, sprint baru, dan closure record disimpan dalam satu
database transaction.
