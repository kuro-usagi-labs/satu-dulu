# Codex Prompt — Bootstrap

```text
Read AGENTS.md, PLANS.md, docs/INDEX.md, docs/05_DESIGN_SYSTEM.md, docs/09_DATA_MODEL.md, and docs/10_FLUTTER_ARCHITECTURE.md.

Bootstrap the Satu Dulu Flutter repository for iOS-first development.

Scope:
- create the Flutter project if missing;
- use the placeholder bundle ID from docs/19_REPO_PLACEHOLDERS.md;
- add Riverpod, go_router, Drift, and the minimum dependencies needed for foundation only;
- create semantic white-theme tokens;
- create a state-preserving four-tab shell: Hari Ini, Proyek, Panduan, Hasil;
- create placeholder screens that demonstrate visual hierarchy without fake full features;
- create database bootstrap with schema version 1;
- add CI format/analyze/test workflow;
- add basic tests for app startup and navigation.

Do not implement project CRUD or PDF import yet.

Run dart format, flutter analyze, and flutter test. Report changed files, tests, and assumptions.
```
