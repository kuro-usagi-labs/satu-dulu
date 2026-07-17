# Release checklist — v1.0.1

## Before tagging

- [x] `dart format --output=none --set-exit-if-changed .` (17 July 2026)
- [x] `flutter analyze` (no issues, 17 July 2026)
- [x] `flutter test --concurrency=1` (32 tests passed, 17 July 2026)
- [x] `flutter build web --release` (including WASM dry run, 17 July 2026)
- [x] Run visual QA on compact and standard iPhone viewports (13 screenshots, 17 July 2026).
- [ ] Manual QA on smallest supported iPhone and a standard modern iPhone.
- [ ] Verify Dynamic Type, Reduce Motion, portrait, and PDF landscape.
- [ ] Test notification permission allowed and denied.
- [ ] Import, reopen offline, rename, resume, and delete a PDF.
- [ ] Exercise onboarding, focus replacement, Ship full/partial, and weekly review.
- [x] Confirm bundle ID `com.kurogi.satudulu` and version/build `1.0.1+2`.
- [x] Confirm palette-only scope: no layout, copy, navigation, state, or data changes.
- [x] Confirm WCAG contrast for text, controls, CTA, and semantic status pairs.
- [x] Confirm no signing files, `.env`, credentials, or personal PDFs are tracked.
- [x] Record release notes in `CHANGELOG.md`.

## Distribution

- [ ] Confirm Flutter CI passes on the v1.0.1 release commit.
- [ ] Run the unsigned IPA workflow from tag `v1.0.1`.
- [ ] Inspect IPA metadata, contents, absence of embedded signing, and SHA-256.
- [ ] Publish `SatuDulu-v1.0.1-unsigned.ipa` on the stable GitHub Release.
- [x] Signed GitHub build intentionally skipped; distribution uses local sideload signing.
- [ ] Re-sign and smoke-test the unsigned IPA on the intended iPhone.

Unsigned IPA artifacts require signing or re-signing with AltStore, Sideloadly,
or an equivalent tool before installation.
