# Test Plan

## Unit tests

### Project domain

- creating first focus succeeds;
- setting second focus moves old focus in one transaction;
- max one maintenance;
- archive behavior;
- sprint date validation;
- maximum three daily actions;
- empty required outcome rejected.

### Ship

- only one ship record per daily plan;
- partial ship supported;
- metrics link optional;
- no rollover debt.

### PDF

- display title rename preserves stored path;
- file import rollback on DB failure;
- delete cascades metadata;
- last page clamped to valid range;
- duplicate bookmark rejected;
- search matches metadata case-insensitively.

### Metrics

- revenue minor-unit conversion;
- weekly totals;
- division by zero for revenue/hour;
- optional values handled.

### Cycle closure

- due hanya setelah end date sprint;
- Continue membuat tepat satu sprint baru;
- Pivot kosong rollback dan Pivot valid menjaga goal project;
- Park dengan/tanpa replacement;
- stale replacement sprint dibatalkan;
- duplicate close ditolak;
- daily plan/action tidak rollover;
- migration v1 → v2 menjaga seluruh data lama.

## Widget tests

- Today with focus;
- Today empty state;
- low energy mode morph;
- Lost Track with and without guide;
- project status conflict dialog;
- PDF list search;
- PDF metadata form validation;
- Results empty state;
- cycle review Continue/Pivot/Park pada 320×640 dan text scale 1,3;
- cycle review invalid/not-due/already-closed state;
- notification permission explanation.

## Integration tests

### Critical path 1

```text
First launch
→ create project
→ create daily plan
→ complete actions
→ ship
→ restart
→ verify persistence
```

### Critical path 2

```text
Import PDF fixture
→ rename title
→ link project
→ open reader
→ navigate page
→ close/restart
→ resume page
→ delete
```

### Critical path 3

```text
Create focus A
→ create focus B
→ choose replacement
→ verify only B focus
→ A parking lot
```

## Manual QA matrix

- small iPhone screen;
- standard iPhone;
- large iPhone;
- portrait;
- PDF landscape;
- larger text;
- Reduce Motion enabled;
- notifications denied;
- no PDFs;
- many PDFs;
- corrupt PDF;
- long title;
- zero metrics;
- Indonesian currency formatting;
- app force close during import.

## Performance checks

- scroll 100 PDF metadata cards;
- open 100+ page PDF;
- search debounce;
- repeated page progress updates;
- startup with database populated;
- no excessive rebuild on Today.

## CI requirements

Every PR:

- format check;
- analyze;
- unit/widget tests.

Before release candidate:

- integration tests;
- iOS release build;
- manual PDF smoke test on physical device;
- migration test from previous schema fixture.
