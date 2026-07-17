# Product Requirements Document

## Product

- Nama: Satu Dulu
- Platform MVP: iOS 16+
- Framework: Flutter
- Language UI: Bahasa Indonesia
- Data strategy: local-first

## Primary jobs to be done

1. Ketika memiliki banyak proyek, saya ingin memilih satu yang harus dikejar agar tenaga tidak tersebar.
2. Ketika membuka aplikasi, saya ingin langsung melihat hasil wajib hari ini agar tidak menghabiskan energi memutuskan ulang.
3. Ketika kehilangan arah, saya ingin melihat tujuan dan panduan proyek agar bisa kembali bekerja.
4. Ketika selesai membuat sesuatu, saya ingin menandainya sebagai shipped dan mencatat hasilnya.
5. Ketika mengevaluasi proyek, saya ingin melihat bukti aktivitas dan hasil agar tahu apakah perlu lanjut, pivot, atau parkir.
6. Ketika memiliki PDF panduan, saya ingin menyimpan, memberi judul yang jelas, menghubungkannya ke proyek, dan melanjutkan bacaan terakhir.

## MVP scope — P0

### Onboarding

- penjelasan singkat konsep satu fokus;
- create first project;
- pilih target sprint;
- set reminder optional;
- permission notification hanya diminta setelah manfaat dijelaskan.

### Projects

- create, edit, archive;
- status focus, maintenance, parkingLot;
- hanya satu focus;
- tujuan, alasan dipilih, target 30 hari, tanggal review;
- guide utama optional.

### Sprint and daily action

- sprint default 30 hari;
- hasil wajib harian;
- maksimal tiga action;
- mark action complete;
- Ship Hari Ini;
- low energy alternative;
- no automatic task debt accumulation.

### Lost Track

- tampilkan focus project;
- tujuan sprint;
- alasan dipilih;
- target hari ini;
- next smallest action;
- guide utama;
- tombol mulai sekarang.

### PDF Library

- import PDF;
- copy file ke app storage;
- display title terpisah dari original filename;
- rename display title;
- project/category/description/when-to-read;
- pin;
- list and search;
- read offline;
- remember last page;
- delete.

### Results

- upload/content count;
- views;
- clicks;
- orders;
- revenue;
- work minutes;
- weekly review.

### Notifications

- morning focus reminder;
- after-work action reminder;
- evening ship check;
- configurable and optional.

## P1

- bookmark PDF page;
- note per page;
- PDF thumbnail;
- guide deep link to page;
- iOS widget;
- idea inbox;
- export JSON/CSV;
- database backup file.

Database backup file sudah diimplementasikan sebagai ZIP lokal v1 yang selalu
menyertakan seluruh PDF. Export JSON/CSV terpisah tetap P1 berikutnya.

## P2

- OCR;
- full-text PDF search;
- iCloud sync;
- AI guide summary;
- AI weekly review;
- Android release;
- App Store distribution.

## Non-functional requirements

- cold start target terasa cepat pada perangkat modern;
- primary interaction tidak bergantung internet;
- scrolling 60 fps pada list normal;
- UI dapat dipakai dengan satu tangan;
- database tetap valid setelah forced close;
- imported PDFs tidak hilang ketika source file dipindahkan;
- tidak ada data analytics pihak ketiga pada MVP;
- destructive action meminta konfirmasi.

## Constraints

- build iOS membutuhkan runner macOS;
- signed IPA membutuhkan konfigurasi signing yang valid;
- PDF scan tidak wajib searchable pada MVP;
- tidak ada login berarti uninstall dapat menghapus data kecuali user mengekspor backup.
