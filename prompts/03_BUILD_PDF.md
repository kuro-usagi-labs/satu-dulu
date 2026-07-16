# Codex Prompt — PDF Library

```text
Read AGENTS.md, docs/08_FEATURE_PDF_LIBRARY.md, docs/09_DATA_MODEL.md, docs/10_FLUTTER_ARCHITECTURE.md, docs/11_IOS_AND_PERMISSIONS.md, docs/13_SECURITY_PRIVACY.md, docs/14_TEST_PLAN.md, and docs/18_ACCEPTANCE_CRITERIA.md.

Implement the PDF Library MVP:
- native PDF import with file_picker;
- validate and copy into Application Documents/pdfs using a UUID filename;
- Drift metadata;
- editable display title while preserving original filename and stored path;
- project/category/description/when-to-read metadata;
- pin, search, list, detail, and delete;
- pdfrx reader;
- save and resume last page;
- link a primary guide to a project and open it from Aku Lupa Arah.

Use transactional/compensating cleanup for file plus DB operations. Handle cancel, corrupt PDF, missing file, and database failure.

Add tests with PDF fixtures. Do not add OCR or full-text search.
```
