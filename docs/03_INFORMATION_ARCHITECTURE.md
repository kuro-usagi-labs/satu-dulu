# Information Architecture

## Primary navigation

Gunakan bottom navigation dengan empat tab:

1. **Hari Ini**
2. **Proyek**
3. **Panduan**
4. **Hasil**

Tab harus tetap konsisten dan tidak berubah berdasarkan state.

## Hierarchy

```text
App
├── Hari Ini
│   ├── Focus summary
│   ├── One required outcome
│   ├── Up to three actions
│   ├── Low energy mode
│   ├── Ship Hari Ini
│   └── Aku Lupa Arah
│
├── Proyek
│   ├── Focus
│   ├── Maintenance
│   ├── Parking Lot
│   ├── Project detail
│   │   ├── Goal
│   │   ├── Sprint
│   │   ├── Daily actions
│   │   ├── Guides
│   │   ├── Metrics
│   │   └── Reviews
│   └── Create/Edit project
│
├── Panduan
│   ├── Search
│   ├── Pinned
│   ├── Continue reading
│   ├── All documents
│   ├── Import flow
│   ├── Document detail
│   └── PDF reader
│
└── Hasil
    ├── Current sprint summary
    ├── Output metrics
    ├── Business metrics
    ├── Weekly review
    └── Project comparison
```

## Content priority on Today

Urutan visual wajib:

1. salam/context kecil;
2. focus project + sprint day;
3. hasil wajib hari ini;
4. primary CTA;
5. tiga action;
6. progress ringkas;
7. recovery shortcut;
8. guide recommendation.

Jangan menaruh chart besar di bagian atas Today.

## Object relationships

- Project memiliki banyak Sprint.
- Satu Project dapat memiliki banyak GuideDocument.
- Sprint memiliki banyak DailyPlan.
- DailyPlan memiliki maksimal tiga DailyAction.
- DailyPlan dapat memiliki satu ShipRecord.
- Project memiliki banyak MetricEntry dan WeeklyReview.
- GuideDocument memiliki banyak PdfBookmark dan PdfNote.

## Empty states

Setiap empty state harus menawarkan satu tindakan jelas:

- belum ada project → `Buat fokus pertama`;
- belum ada PDF → `Tambahkan panduan`;
- belum ada metrik → `Catat hasil hari ini`;
- belum ada focus → `Pilih satu fokus`.
