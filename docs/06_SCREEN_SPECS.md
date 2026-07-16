# Screen Specifications

## 1. Splash

Hierarchy:

1. small centered logo mark;
2. app name;
3. no progress percentage.

Duration hanya selama initialization. Jangan membuat splash animasi panjang.

## 2. Onboarding

### Screen 1 — Promise

- Headline: `Banyak ide boleh. Hari ini tetap satu dulu.`
- Supporting illustration abstrak minimal.
- CTA: `Mulai`.

### Screen 2 — One focus rule

- Visual tiga project cards, satu highlighted.
- Copy singkat.
- CTA: `Pilih fokus`.

### Screen 3 — Create first project

Fields:

- nama proyek;
- tujuan;
- kenapa dipilih;
- target 30 hari;
- tanggal mulai;
- warna/icon optional.

### Screen 4 — Today's outcome

- hasil wajib hari ini;
- maksimal tiga action;
- optional reminder.

## 3. Today

Visual hierarchy:

```text
Top bar: greeting + settings icon
Context label: Fokus 30 hari
Hero card:
  project name
  day x/30
  required outcome
  progress
Primary CTA: Mulai / Ship Hari Ini
Action list (max 3)
Low energy shortcut
Aku Lupa Arah card
Guide recommendation
Compact weekly result
Bottom navigation
```

Hero card harus mendominasi tanpa memenuhi seluruh layar.

## 4. Lost Track sheet/page

Sections:

1. `Kamu sedang mengerjakan`;
2. project name;
3. tujuan sprint;
4. alasan dipilih;
5. hasil wajib hari ini;
6. tindakan terkecil;
7. primary guide;
8. CTA `Kerjakan sekarang`.

Gunakan progressive disclosure. Jangan memunculkan analytics penuh.

## 5. Projects list

Sections berurutan:

- Focus;
- Maintenance;
- Parking Lot.

Floating action button putih/accent minimal untuk tambah proyek.

## 6. Project detail

Top:

- project identity;
- status;
- current sprint;
- edit menu.

Tabs/sections:

- Ringkasan;
- Rencana;
- Panduan;
- Hasil.

Pada ponsel, gunakan segmented control kecil atau scroll section, bukan nested bottom navigation.

## 7. Create/Edit project

Gunakan form berkelompok:

- Identitas;
- Arah;
- Status;
- Sprint;
- Reminder;
- Panduan utama.

Simpan button sticky di bawah keyboard-aware area.

## 8. Guides library

Top:

- title `Panduan`;
- search field;
- import button.

Sections:

- pinned;
- continue reading;
- all documents.

Filter chips:

- project;
- category;
- pinned.

Toggle grid/list optional tetapi list adalah default MVP.

## 9. Import PDF metadata

Preview top:

- first-page thumbnail or PDF icon;
- original filename;
- file size.

Fields:

- display title;
- project;
- category;
- description;
- when to read;
- pin.

## 10. PDF detail

- thumbnail;
- display title;
- original filename kecil;
- linked project;
- category/tags;
- progress;
- continue reading CTA;
- notes/bookmarks summary;
- rename/edit/delete menu.

## 11. PDF reader

Chrome minimal:

- back;
- title truncated;
- page indicator;
- overflow.

Bottom controls fade when reading:

- thumbnails;
- page jump;
- bookmark;
- note;
- fit width.

Background reader menggunakan light gray agar halaman putih tetap terlihat.

## 12. Results

Top summary:

- shipped outputs this sprint;
- work time;
- revenue optional.

Cards:

- views;
- clicks;
- orders;
- revenue;
- output per week.

Chart jangan lebih dari satu per section. Hindari dashboard padat.

## 13. Weekly review

Step form:

1. apa yang diterbitkan;
2. hasil paling penting;
3. apa yang bekerja;
4. apa yang membuang waktu;
5. keputusan continue/pivot/park;
6. next week focus.

## 14. Settings

- notifications;
- appearance: light only MVP, system later;
- export/backup;
- privacy;
- about;
- destructive reset data.
