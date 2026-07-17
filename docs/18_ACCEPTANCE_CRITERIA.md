# Acceptance Criteria

Status diperbarui 17 Juli 2026 berdasarkan test otomatis dan inspeksi source. Item yang memerlukan artefak GitHub atau perangkat fisik tetap terbuka sampai ada bukti eksekusi.

## Today

- [x] Focus project visible immediately.
- [x] Sprint day visible.
- [x] Exactly one required outcome emphasized.
- [x] No more than three actions shown.
- [x] Ship CTA reachable without opening another tab.
- [x] Low energy mode available.
- [x] Lost Track reachable in one tap.

## Project status

- [x] Database never ends with two focus projects.
- [x] User understands what happens to previous focus.
- [x] Parking Lot items remain accessible but not pushed daily.

## Ship

- [x] Can record full or partial ship.
- [x] Persists after restart.
- [x] Duplicate ship is prevented or edited intentionally.
- [x] Ship immediately appears as at least one output in Results.
- [x] Numeric metric handoff remains optional.
- [x] Success animation respects Reduce Motion.

## Lost Track

- [x] Shows project goal and why chosen.
- [x] Shows today's outcome.
- [x] Shows smallest action.
- [x] Opens primary guide when available.
- [x] Works with missing guide.

## 30-day cycle

- [x] Today derives due state from sprint status/date, not weekly review.
- [x] Continue closes the old sprint and starts one fresh 30-day cycle.
- [x] Pivot requires a new approach without changing the project goal.
- [x] Park supports a replacement focus or an explicit choose-later state.
- [x] Decision is atomic and duplicate submission is rejected.
- [x] Evidence is limited to the sprint date range.
- [x] Old daily plans and actions do not roll into the new cycle.
- [x] Schema v1 data is preserved by migration v2.

## PDF import

- [x] Only accepted PDF proceeds.
- [x] Source cancel returns safely.
- [x] File copied to app storage.
- [x] Metadata created only after valid copy.
- [x] Imported PDF survives source removal and app restart.
- [x] Rename changes display title only.

## PDF reader

- [x] Opens offline.
- [x] Supports zoom and scrolling.
- [x] Shows page position.
- [x] Saves last page.
- [x] Resumes after restart.
- [x] Corrupt PDF shows recoverable error.

## Local backup and restore

- [x] Backup includes every schema v2 table and all guide PDFs.
- [x] Manifest and file checksums are verified before confirmation.
- [x] Restore requires explicit destructive confirmation.
- [x] Database replacement is atomic and constraint failure preserves old data.
- [x] PDF swap rolls back when database restore fails.
- [x] Web preview disables native file operations gracefully.
- [ ] Save/open through Files and iCloud provider verified on physical iPhone.
- [ ] Force-close and low-storage restore recovery verified on physical iPhone.

## Design

- [x] White minimalist theme used consistently.
- [x] No random colors outside token system.
- [x] Main card radius and spacing consistent.
- [x] Tap targets at least 44x44.
- [ ] Long text does not overflow (physical-device Dynamic Type QA pending).
- [x] Motion is smooth and functional in automated/widget inspection; device QA pending.

## CI

- [x] PR runs format check, analyze, tests.
- [x] iOS build uses macOS runner.
- [x] unsigned IPA workflow creates artifact (run `29525454301`, tag `v0.1.0`).
- [x] signed workflow does not expose secrets.
- [x] release build failure is actionable through named workflow steps.
