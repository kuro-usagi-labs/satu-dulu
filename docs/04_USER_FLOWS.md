# User Flows

## Flow A — First launch

```text
Launch
→ Value proposition
→ Explain Pilih / Kerjakan / Ship
→ Explain the job of Hari Ini / Proyek / Panduan / Hasil
→ Create first focus in three guided steps
   1. Name, goal, and why now
   2. 30-day evidence and today's required outcome
   3. Up to three actions and an optional low-energy version
→ Today screen
```

Onboarding maksimal tiga layar penjelasan sebelum setup fokus. Pengguna boleh
melewati penjelasan, tetapi tetap harus membuat fokus dan hasil hari pertama
sebelum masuk ke Today.

## Flow B — Daily use

```text
Open app
→ See focus and required outcome
→ See the first incomplete action emphasized
→ Work in the app or externally
→ Complete actions
→ Tap Ship Hari Ini
→ Add optional link/note evidence
→ Save one shipped output into Hasil automatically
→ Success confirmation
→ Optional numeric metric handoff or finish the day
```

Today CTA rules:

- no focus → `Buat fokus pertama` or `Pilih dari proyek`;
- focus but no plan → `Tentukan hasil hari ini`;
- active plan → `Ship Hari Ini`;
- shipped → output evidence is already counted + optional `Catat angka hasil`;
- review date passed → `Review fokus ini`.

## Flow C — Low energy

```text
Today
→ Tap Energi Lagi Rendah
→ App shows reduced action
→ User accepts or edits
→ Complete smallest action
→ Ship partial/maintenance output
```

Bahasa UI tidak boleh memberi kesan gagal. Contoh: `Kecilkan langkahnya, jangan hilangkan arahnya.`

## Flow D — Lost track

```text
Today
→ Aku Lupa Arah
→ Focus purpose card
→ Why this project card
→ Today's required outcome
→ Smallest next action
→ Kerjakan sekarang scrolls back to the emphasized action
→ Or open the primary guide
```

Target: pengguna mencapai tindakan konkret dalam maksimal dua tap setelah membuka recovery sheet.

## Flow E — Create project while another focus exists

```text
Create project
→ Choose status Focus
→ System detects existing focus
→ Explain one-focus rule
→ Options:
   - Make new project focus and move old to parking lot
   - Save new project to parking lot
   - Cancel
```

Tidak boleh ada dua focus project akibat race condition atau import.

## Flow F — Import PDF

```text
Panduan
→ Tambah PDF
→ Native file picker
→ Validate PDF
→ Copy to app storage
→ Metadata form
→ Save
→ Document detail
```

Metadata minimal:

- display title;
- project optional;
- category;
- description optional;
- when to read optional;
- pinned boolean.

## Flow G — Resume PDF

```text
Open document card
→ If last page > 1, show resume affordance
→ Open reader at last page
→ Page changes are persisted with debounce
→ Exit
→ Card progress updated
```

## Flow H — Weekly review

```text
Review reminder
→ See weekly shipped outputs and metrics
→ Answer prompts
→ Choose Continue / Pivot / Park
→ Generate next-week focus statement
→ Save review
```
