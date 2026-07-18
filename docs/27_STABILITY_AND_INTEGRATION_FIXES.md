# ExecPlan — Stability and integration fixes

Tanggal: 18 Juli 2026

## Objective

Menutup temuan audit lintas fitur pada lifecycle proyek, onboarding, arsip,
review, PDF reader, penghapusan PDF, dan zona waktu notifikasi tanpa mengubah
prinsip local-first atau menambah beban pada layar Today.

## Product constraints

- Putaran baru tidak membawa daily plan atau action lama.
- Proyek arsip tetap dapat ditemukan, tetapi tidak kembali memenuhi daftar utama.
- Review mingguan menyimpan refleksi dan Restart Capsule; hanya cycle review yang
  boleh menutup sprint atau mengubah status proyek.
- Review mingguan hanya tersedia untuk fokus aktif.
- Penghapusan PDF tidak boleh menyisakan metadata yang menunjuk file hilang.
- Kegagalan reader PDF harus terlihat dan dapat dicoba kembali.
- Pengingat mengikuti zona waktu perangkat saat dijadwalkan ulang.

## Implementation

1. Sertakan proyek arsip pada stream repository, tampilkan dalam section
   collapsible, dan izinkan Hasil membacanya.
2. Ubah aktivasi proyek agar membuat sprint baru tanpa menyalin plan lama;
   Restart Capsule tetap menjadi konteks yang ditampilkan di Today.
3. Jadikan arsip proyek satu transaction.
4. Pisahkan weekly review dari lifecycle sprint dan tolak review non-focus.
5. Hapus metadata PDF sebelum file fisik agar library tidak menunjuk file yang
   sudah hilang; kegagalan cleanup menjadi warning recoverable.
6. Serialisasi persistence halaman, bookmark, dan note serta tampilkan error UI.
7. Tambahkan `flutter_timezone` untuk memperoleh IANA timezone perangkat. Ini
   diperlukan karena package `timezone` tidak dapat mendeteksi timezone perangkat
   sendiri dan `flutter_local_notifications` merekomendasikan pendekatan tersebut.
8. Tambahkan regression test untuk seluruh invariant yang berubah.

## Validation

- `dart format --output=none --set-exit-if-changed .`
- `flutter analyze`
- `flutter test --concurrency=1`
- `flutter build web --release`
- GitHub macOS iOS build untuk integrasi plugin timezone.

## Risks and rollback

- Stream proyek kini memuat arsip; seluruh consumer harus memfilter hanya ketika
  konteksnya membutuhkan proyek aktif.
- Perubahan makna weekly review harus tercermin konsisten pada copy dan test.
- Plugin timezone menambah integrasi native; rollback dilakukan dengan kembali ke
  fallback timezone tersimpan bila plugin gagal, bukan menggagalkan pengingat.
