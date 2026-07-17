# Design System — Calm Editorial Focus

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

Motif visual utama adalah **satu penanda fokus**: rail, angka `01`, atau satu
surface beraksen di antara surface netral. Hierarchy dibuat lewat typography,
whitespace, dan komposisi—bukan border pada setiap blok.

## Color tokens

```text
Background / Canvas      #F5F2EC
Canvas Deep              #ECE6DC
Surface Primary          #FFFDF9
Surface Secondary        #F0ECE4
Surface Warm             #F8EDE5
Text Primary             #20251F
Text Secondary           #646B63
Text Tertiary            #686F67
Border Subtle            #E4DED3
Control Border           #868D85
Divider                  #E9E3D9
Accent Primary           #BC482F
Accent Deep              #9C3B27
Accent Soft              #FBE7DE
Success                  #3B735A
Success Soft             #E7F0EA
Warning                  #A66D1E
Warning Soft             #F7EEDB
Danger                   #A83F39
Danger Soft              #F7E6E4
Guide Context            #536A5B
Guide Soft               #E8EFEA
```

Gunakan accent terracotta secara hemat untuk CTA, selected state, focus marker,
dan progress. Guide green hanya digunakan dalam konteks membaca/recovery. Jangan
memberi warna pada setiap kartu.

Teks dan batas control harus tetap terbaca pada canvas terang. Kombinasi utama
memenuhi WCAG AA untuk teks normal: inverse/accent 4,96:1, tertiary/canvas
4,63:1, danger/danger-soft 5,06:1. `Control Border` dipakai untuk field dan
outlined control karena kontrasnya minimal 3:1; `Border Subtle` hanya untuk
divider atau pemisah dekoratif. Jangan menurunkan opacity teks informatif.

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
0 8 18 rgba(89, 69, 54, 0.05)

Floating primary:
0 14 32 rgba(82, 59, 46, 0.09)

Focus hero:
0 14 28 rgba(188, 72, 47, 0.14)
```

Border halus atau perubahan surface lebih disukai daripada shadow tebal. Jangan
memberi border yang sama pada semua kartu.

## Core components

### Primary button

- height 54;
- radius 16;
- full width pada action utama;
- accent background;
- white label 16/650;
- pressed scale 0.985;
- haptic light.

### Secondary button

- surface white;
- subtle border;
- no heavy shadow;
- pressed background `Surface Secondary`.

### Focus hero card

- white surface;
- 24 radius;
- title focus;
- sprint progress;
- required outcome;
- one dominant CTA;
- optional small guide shortcut.

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

## Motion system

### Principles

- animasi menjelaskan perubahan state;
- tidak ada animasi dekoratif yang menghambat;
- interruption-friendly;
- respect Reduce Motion.

### Durations

```text
Tap feedback          100–140 ms
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

## Accessibility

- minimum tap target 44x44;
- contrast text memenuhi standar normal;
- Dynamic Type-friendly layout;
- semantic labels for icon-only button;
- do not encode status by color only;
- support Reduce Motion;
- reader controls remain usable in landscape.
