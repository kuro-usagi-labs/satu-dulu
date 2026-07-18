# MVP implementation audit

Tanggal audit lokal: 17 Juli 2026.

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
| Database migration | Drift schema v1 baseline plus migration/data-preservation verification |
| Local backup/restore | ZIP v1 manifest/checksum, all schema v3 tables, full PDF staging, database transaction, and rollback tests |
| Release assets | 19 opaque iOS icons, web icons, branded launch screen, and deterministic generator |
| Privacy | Runner privacy manifest declares no tracking or off-device collection |

## Local validation completed

- `dart format .`
- `flutter analyze` — no issues
- `flutter test --concurrency=1` — 24 tests passed
- `flutter build web --release` — succeeded, including WASM dry run
- Local HTTP checks for HTML, app bundle, Drift worker, and SQLite WASM — HTTP 200
- Workflow YAML parse and signing-material scan — passed
- App icon dimension/alpha and plist/storyboard XML validation — passed

## GitHub release validation

- Flutter CI run `29525231912` passed on commit `5b9ad62`.
- Unsigned iOS run `29525454301` passed from tag `v0.1.0` on macOS 15.
- Artifact `satu-dulu-unsigned-ipa` contains `SatuDulu-unsigned.ipa` (13,421,020 bytes).
- IPA metadata: `com.kurogi.satudulu`, version `0.1.0` build `1`, minimum iOS `16.0`.
- Runner privacy manifest is present.
- No embedded provisioning profile or `_CodeSignature` is present, as expected for the unsigned workflow.
- IPA SHA-256: `6566EDD39D2D9460BE693100E8A15EA81CFD5A64FF41474B4529BF445195746C`.

## Requires macOS or physical-device validation

- Build the iOS target on the configured macOS GitHub runner.
- Install and smoke-test an unsigned re-signed or signed IPA.
- Test notification permission allowed and denied on iOS.
- Verify reminder delivery across app restart and timezone changes.
- Test PDF import from Files/iCloud provider and source removal.
- Inspect smallest supported iPhone, Dynamic Type, Reduce Motion, and PDF landscape.
- Re-sign the released unsigned IPA with the selected sideload tool and smoke-test it on the intended iPhone.
- Save a full backup through Files/iCloud, restore it, and verify every PDF.
- Exercise low storage and force-close during restore; process-kill recovery
  remains a release gate beyond the tested compensating rollback.

These items remain release gates; Windows cannot provide credible evidence for them.

The owner intentionally chose sideload distribution for `v0.1.0`; GitHub-hosted Apple signing is not a release requirement.
