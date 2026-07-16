# Release checklist

## Before tagging

- [ ] `dart format --output=none --set-exit-if-changed .`
- [ ] `flutter analyze`
- [ ] `flutter test`
- [ ] Manual QA on smallest supported iPhone and a standard modern iPhone.
- [ ] Verify Dynamic Type, Reduce Motion, portrait, and PDF landscape.
- [ ] Test notification permission allowed and denied.
- [ ] Import, reopen offline, rename, resume, and delete a PDF.
- [ ] Exercise onboarding, focus replacement, Ship full/partial, and weekly review.
- [ ] Confirm bundle ID `com.kurogi.satudulu` and intended version/build number.
- [ ] Confirm no signing files, `.env`, credentials, or personal PDFs are tracked.

## Distribution

- [ ] Run unsigned IPA workflow and inspect artifact.
- [ ] For signed build, use protected `ios-build` environment and configured secrets.
- [ ] Install the signed build on an intended device before sharing.
- [ ] Record release notes in `CHANGELOG.md`.

Unsigned IPA artifacts require signing or re-signing before installation.
