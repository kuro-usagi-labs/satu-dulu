# PDF Library Feature Specification

## Purpose

PDF Library menyimpan panduan yang dapat dipanggil pada konteks proyek. Fitur ini harus terasa seperti library pribadi, bukan file explorer teknis.

## Import

### Supported

- `.pdf` only untuk MVP;
- single file import;
- source melalui native iOS document picker.

### Validation

- extension and MIME hint;
- file can be opened;
- page count > 0;
- configurable size limit warning, bukan hard limit kecil;
- duplicate detection optional menggunakan SHA-256.

### Storage flow

1. user memilih source file;
2. app memperoleh temporary/security-scoped access;
3. app menyalin file ke Application Documents/PDFs;
4. stored filename menggunakan UUID;
5. metadata disimpan setelah copy berhasil;
6. jika database save gagal, copied file dibersihkan;
7. jika copy gagal, metadata tidak dibuat.

Suggested path:

```text
<ApplicationDocuments>/pdfs/<document-uuid>.pdf
```

## Metadata

- id;
- originalFileName;
- displayTitle;
- storedRelativePath;
- fileSizeBytes;
- checksum optional;
- projectId optional;
- category;
- description optional;
- whenToRead optional;
- isPinned;
- pageCount;
- lastReadPage;
- lastOpenedAt;
- importedAt;
- updatedAt.

## Rename

Rename hanya mengubah `displayTitle`.

UI tetap menyediakan original filename sebagai metadata sekunder. Jangan rename stored physical file kecuali ada requirement baru.

## Categories

Default:

- Strategi
- Kalender
- Tutorial
- Skrip
- Riset
- Evaluasi
- Produk
- Referensi
- Lainnya

Kategori disimpan sebagai string/key agar bisa dikustomisasi di versi berikutnya.

## Search

MVP mencari:

- display title;
- original filename;
- description;
- when-to-read;
- category;
- project name.

Debounce 200–300 ms. Search offline.

## Library sections

1. Pinned;
2. Continue reading;
3. All documents.

Satu dokumen tidak perlu diduplikasi secara visual di banyak section bila membingungkan; section horizontal boleh mereferensikan card ringkas.

## Reader

Requirements:

- offline;
- vertical continuous default;
- pinch zoom;
- fit width;
- page indicator;
- jump to page;
- remember page;
- loading per page;
- corrupted file state;
- landscape support.

Persist last page menggunakan debounce supaya tidak menulis database pada setiap pixel scroll.

## Bookmark — P1

Unique constraint:

```text
(documentId, pageNumber)
```

## Notes — P1

Note terhubung ke document and page. Tidak perlu text annotation langsung pada PDF.

Fields:

- id;
- documentId;
- pageNumber;
- content;
- createdAt;
- updatedAt.

## Project linking

- satu PDF terhubung ke maksimal satu primary project pada MVP;
- project memiliki banyak PDF;
- primary guide disimpan pada Project;
- daily plan dapat link ke PDF dan halaman tertentu.

## Delete

Flow:

- confirmation menampilkan title;
- delete database child records;
- delete physical file;
- jika physical delete gagal, tampilkan warning dan tandai cleanup needed;
- never delete source file outside app sandbox.

## Empty/error states

- no document: `Tambahkan PDF panduan pertamamu.`
- file unavailable: `File panduan tidak ditemukan di penyimpanan aplikasi.`
- corrupt: `PDF ini tidak dapat dibaca.`
- password protected unsupported: jelaskan keterbatasan tanpa crash.

## Future features

- OCR;
- full-text indexing;
- text highlight;
- AI summary;
- semantic search;
- iCloud document sync.
