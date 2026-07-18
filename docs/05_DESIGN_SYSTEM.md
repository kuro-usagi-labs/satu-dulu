# Design System — Warm Editorial Focus

## Design direction

Aplikasi harus terasa:

- modern;
- tenang;
- editorial dan personal, bukan dashboard korporat;
- premium tetapi tidak mewah berlebihan;
- ringan;
- personal;
- fokus pada satu keputusan;
- dekat dengan native iOS.

Hindari tampilan dashboard gelap, kartu terlalu padat, gradient neon, atau visual produktivitas korporat.

Motif visual utama adalah **banyak arah menuju satu fokus**: angka `01`, satu
titik tujuan, atau satu surface beraksen di antara surface netral. Hierarchy
dibuat lewat typography, whitespace, dan komposisi—bukan border pada setiap
blok.

Referensi orange–black diterjemahkan secara semantik, bukan disalin sebagai
dashboard gelap. White theme tetap dominan; near-black hanya menjadi surface
bukti/keputusan yang disengaja.

## Color tokens

```text
Background / Canvas      #F7F5F2
Canvas Deep              #EFECE8
Surface Primary          #FFFFFF
Surface Secondary        #F2EFEB
Surface Pressed          #E8E4DF
Text Primary / Evidence  #171717
Text Secondary           #5D5652
Text Tertiary            #6B645F
Text Inverse             #FFFFFF
Border Subtle            #DEDAD4
Control Border           #827A74
Divider                  #E7E3DE
Action Orange            #F25926
On Action                #171717
Action Pressed           #DF5122
Action Deep              #B63812
Action Soft              #F8DCCF
Evidence                 #171717
On Evidence              #FFFFFF
Evidence Muted           #C9C2BC
Guide Orange             #B63812
Guide Deep               #B63812
Guide Soft               #F8DCCF
Success                  #087A55
Success Soft             #E6F6EF
Parking                  #625D59
Parking Soft             #ECE9E5
Warning                  #8A5700
Warning Soft             #FFF2D1
Danger                   #B42318
Danger Soft              #FDECEA
```

Peran warna wajib konsisten:

- orange = tindakan, fokus aktif, Ship, pinned, dan data mark;
- near-black = bukti serta keputusan, bukan dashboard penuh;
- orange = aksi utama, Panduan, reader, dan recovery;
- green = berhasil dan proyek Tetap dijaga;
- gray = Disimpan dulu;
- amber/red = warning dan destructive state.

Teks dan batas control harus tetap terbaca pada canvas terang. Kombinasi utama
memenuhi WCAG AA untuk teks normal: ink/action 5,32:1, guide/white 5,93:1,
success/success-soft 4,79:1, parking/parking-soft 5,37:1, dan
inverse/evidence 17,93:1. `Control Border` terhadap white adalah 4,21:1.
`Action Deep` terhadap `Action Soft` minimal 4,5:1 agar label orange-soft tetap
terbaca.
`Border Subtle` hanya untuk divider atau pemisah dekoratif. Jangan menurunkan
opacity teks informatif.

## Typography

Gunakan system font. Jangan bundel font custom pada MVP.

| Token | Size | Weight | Line height | Use |
|---|---:|---:|---:|---|
| Display | 40 | 800 | 44 | Promise dan fokus utama tertentu |
| H1 | 31 | 800 | 36 | Judul screen |
| H2 | 24 | 700 | 30 | Section utama |
| H3 | 19 | 700 | 25 | Card title |
| Body Large | 17 | 400 | 25 | Copy penting |
| Body | 15 | 400 | 22 | Copy umum |
| Label | 13 | 600 | 18 | Label dan metadata |
| Eyebrow | 12 | 700 | 16 | Context label dengan tracking positif |
| Caption | 12 | 400 | 17 | Detail sekunder |

Gunakan sentence case. Hindari semua huruf kapital kecuali label sangat pendek.

## Spacing

Base unit 4.

```text
4   micro
8   compact
12  inner compact
16  standard
20  generous
24  section
32  major separation
40  screen breathing room
```

Screen horizontal padding: 20 px pada iPhone umum, minimum 16 px pada width kecil.

## Radius

```text
Small control       10
Input               16
Button               18
Card                 22
Hero card            24
Bottom sheet top     28
Pill                 999
```

## Shadows

Gunakan sangat lembut.

```text
Card default:
0 8 18 rgba(59, 46, 40, 0.05)

Floating primary:
0 12 28 rgba(59, 46, 40, 0.08)

Focus hero:
0 14 28 rgba(242, 89, 38, 0.14)
```

Border halus atau perubahan surface lebih disukai daripada shadow tebal. Jangan
memberi border yang sama pada semua kartu.

## Core components

### Primary button

- height 54;
- radius 16;
- full width pada action utama;
- action orange background;
- near-black label 16/650;
- pressed scale 0.985;
- tanpa haptic kecuali event kunci.

### Secondary button

- surface white;
- subtle border;
- no heavy shadow;
- pressed background `Surface Secondary`.

### Focus hero card

- action-soft surface;
- 24 radius;
- title focus;
- sprint progress;
- required outcome;
- one dominant CTA;
- optional small guide shortcut.

### Evidence card

- satu near-black surface per konteks Hasil;
- angka besar memakai tabular figures;
- label putih dan evidence-muted;
- data mark/garis chart memakai action orange;
- jangan mengubah seluruh layar menjadi dark dashboard.

### Status pill

- selalu menampilkan label, bukan warna saja;
- Fokus utama orange, Tetap dijaga green, Disimpan dulu gray;
- tetap dapat wrap pada Dynamic Type tanpa overflow.

### Empty state

- tinggi selalu mengikuti isi, tanpa fixed height atau spacer dekoratif;
- padding 16 dan ikon stiker 40;
- ikon sejajar dengan judul pada baris pertama;
- deskripsi memakai lebar penuh agar tidak menjadi kolom teks sempit;
- action, bila ada, berada 16 px setelah copy;
- pada layar 320 px, komponen harus tetap compact dan boleh bertambah tinggi
  hanya karena Dynamic Type.

### Project card

- left status indicator kecil;
- title + one-line goal;
- status chip;
- next review;
- no more than three metadata rows.

### PDF card

- thumbnail ratio kira-kira 3:4;
- title maksimum dua baris;
- project/category metadata;
- progress line;
- continue button/chevron.

### Bottom sheet

- white;
- top radius 28;
- drag handle;
- max height adaptive;
- respect keyboard and safe area.
- memakai `AppMotion.sheet(context)` agar timing konsisten dan menjadi nol saat
  Reduce Motion aktif.

## Motion system

### Principles

- animasi menjelaskan perubahan state;
- tidak ada animasi dekoratif yang menghambat;
- interruption-friendly;
- respect Reduce Motion.

### Durations

```text
Tap feedback          120–200 ms
Small state change    180–220 ms
Card transition       240–300 ms
Bottom sheet          300–360 ms
Success emphasis      450–650 ms
```

### Curves

- standard entrance: `easeOutCubic`;
- state morph: `easeInOutCubic`;
- spring only for small success/icon interactions;
- avoid bounce besar.

### Suggested animations

- Today hero card fade + 8 px slide on first load;
- checked action smoothly collapses secondary detail;
- Ship success uses subtle check ring and count increment;
- tab switch uses preserved state and short fade;
- PDF cards use shared-axis-like transition into reader;
- low energy mode morphs action card instead of replacing whole screen.
- onboarding sticker dan evidence sparkline memakai vector `CustomPainter`
  yang bergerak satu kali lalu berhenti; tidak menambah dependency SVG.

## Accessibility

- minimum tap target 44x44;
- contrast text memenuhi standar normal;
- Dynamic Type-friendly layout;
- semantic labels for icon-only button;
- progress bar dekoratif tidak boleh menggabungkan seluruh semantic tree;
- card action memakai semantic container agar label tombol tidak menelan sibling;
- do not encode status by color only;
- support Reduce Motion;
- reader controls remain usable in landscape.
