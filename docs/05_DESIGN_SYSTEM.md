# Design System — White Minimalist

## Design direction

Aplikasi harus terasa:

- modern;
- tenang;
- premium tetapi tidak mewah berlebihan;
- ringan;
- personal;
- fokus pada satu keputusan;
- dekat dengan native iOS.

Hindari tampilan dashboard gelap, kartu terlalu padat, gradient neon, atau visual produktivitas korporat.

## Color tokens

```text
Background / Canvas      #F6F7F9
Surface Primary          #FFFFFF
Surface Secondary        #F0F2F5
Surface Elevated         #FFFFFF
Text Primary             #111318
Text Secondary           #676D78
Text Tertiary            #9298A3
Border Subtle            #E7E9EE
Divider                   #ECEEF2
Accent Primary           #4468F2
Accent Soft              #EEF2FF
Success                  #1F9D68
Success Soft             #EAF8F1
Warning                  #C98512
Warning Soft             #FFF6DF
Danger                   #D84A4A
Danger Soft              #FFF0F0
Purple Guide             #7157D9
Purple Guide Soft        #F2EFFF
```

Gunakan accent biru secara hemat untuk CTA, selected state, dan progress. Jangan memberi warna pada setiap kartu.

## Typography

Gunakan system font. Jangan bundel font custom pada MVP.

| Token | Size | Weight | Line height | Use |
|---|---:|---:|---:|---|
| Display | 34 | 700 | 40 | Angka/fokus utama tertentu |
| H1 | 28 | 700 | 34 | Judul screen |
| H2 | 22 | 650 | 28 | Section utama |
| H3 | 18 | 650 | 24 | Card title |
| Body Large | 17 | 400 | 24 | Copy penting |
| Body | 15 | 400 | 22 | Copy umum |
| Label | 13 | 600 | 18 | Label dan metadata |
| Caption | 12 | 400 | 16 | Detail sekunder |

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
Small control       12
Input               14
Button               16
Card                 20
Hero card            24
Bottom sheet top     28
Pill                 999
```

## Shadows

Gunakan sangat lembut.

```text
Card default:
0 1 2 rgba(17, 19, 24, 0.04)
0 8 24 rgba(17, 19, 24, 0.04)

Floating primary:
0 12 32 rgba(68, 104, 242, 0.18)
```

Border halus lebih disukai daripada shadow tebal.

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
