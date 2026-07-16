# MVP implementation audit

Tanggal audit lokal: 16 Juli 2026.

## Implemented and automated

| Area | Evidence |
|---|---|
| One focus and one maintenance | Atomic repository rules and `tracker_repository_test.dart` |
| Today, max three actions, no rollover | Today widget/repository tests |
| Full/partial Ship and duplicate prevention | Tracker repository tests |
| Low energy and Lost Track | Today screen; primary guide opens in one recovery sheet |
| PDF import and local copy | Native file service with validation and rollback coordinator |
| Offline reader and resume | `pdfrx` file reader, debounced page persistence, lifecycle flush |
| PDF metadata/search/delete | Drift guide repository and guide repository tests |
| PDF P1 | Thumbnail grid, bookmarks, notes, linked-page query open |
| Metrics | Minor-unit conversion, safe derived values, repository tests |
| Weekly review | One review per project/week and Continue/Pivot/Park decision |
| Notifications | Opt-in preferences, permission education, local rescheduling |
| Accessibility basics | Semantic Material controls, Dynamic Type layout, Reduce Motion handling |
| Windows preview | Flutter web release, Drift worker, and SQLite WASM over local HTTP |
| CI and IPA definitions | PR CI, unsigned macOS workflow, protected manual signed workflow |
| Identity | Bundle ID `com.kurogi.satudulu`; repository remote configured |

## Local validation completed

- `dart format .`
- `flutter analyze` — no issues
- `flutter test --concurrency=1` — 22 tests passed
- `flutter build web --release` — succeeded, including WASM dry run
- Local HTTP checks for HTML, app bundle, Drift worker, and SQLite WASM — HTTP 200
- Workflow YAML parse and signing-material scan — passed

## Requires macOS or physical-device validation

- Build the iOS target on the configured macOS GitHub runner.
- Install and smoke-test an unsigned re-signed or signed IPA.
- Test notification permission allowed and denied on iOS.
- Verify reminder delivery across app restart and timezone changes.
- Test PDF import from Files/iCloud provider and source removal.
- Inspect smallest supported iPhone, Dynamic Type, Reduce Motion, and PDF landscape.
- Confirm signing profile matches `com.kurogi.satudulu` before a signed build.

These items remain release gates; Windows cannot provide credible evidence for them.
