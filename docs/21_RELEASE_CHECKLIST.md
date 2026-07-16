# Release checklist

## Before tagging

- [x] `dart format --output=none --set-exit-if-changed .` (17 July 2026)
- [x] `flutter analyze` (no issues, 17 July 2026)
- [x] `flutter test` (24 tests passed, 17 July 2026)
- [ ] Manual QA on smallest supported iPhone and a standard modern iPhone.
- [ ] Verify Dynamic Type, Reduce Motion, portrait, and PDF landscape.
- [ ] Test notification permission allowed and denied.
- [ ] Import, reopen offline, rename, resume, and delete a PDF.
- [ ] Exercise onboarding, focus replacement, Ship full/partial, and weekly review.
- [x] Confirm bundle ID `com.kurogi.satudulu` and version/build `0.1.0+1`.
- [x] Confirm no signing files, `.env`, credentials, or personal PDFs are tracked.

## Distribution

- [ ] Run unsigned IPA workflow and inspect artifact.
- [ ] For signed build, use protected `ios-build` environment and configured secrets.
- [ ] Install the signed build on an intended device before sharing.
- [x] Record release notes in `CHANGELOG.md`.

Unsigned IPA artifacts require signing or re-signing before installation.
