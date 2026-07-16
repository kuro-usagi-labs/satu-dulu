# User Flows

## Flow A — First launch

```text
Launch
→ Value proposition
→ Explain one-focus rule
→ Create first project
→ Add goal and 30-day target
→ Create today's required outcome
→ Optional reminder setup
→ Today screen
```

Onboarding maksimal empat layar sebelum form proyek. Harus bisa dilewati setelah proyek pertama berhasil dibuat.

## Flow B — Daily use

```text
Open app
→ See focus and required outcome
→ Review up to three actions
→ Start focus session or work externally
→ Complete actions
→ Tap Ship Hari Ini
→ Add optional evidence and metrics
→ Success confirmation
```

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
→ Open primary guide or Start now
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
