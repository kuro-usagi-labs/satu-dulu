# Changelog

## 1.2.1 — Integrated local edition

- Restored the warm editorial theme and complete local-first workflow that had
  remained outside the GitHub main branch.
- Integrated Idea Inbox, Daily Check-in, Recovery Mode, Restart Capsule, and
  applied weekly-review decisions into the local Today experience.
- Combined 30-day cycle closure and anti-forget storage in Drift schema v3,
  with safe migration from either previously released schema-v2 variant.
- Extended local backup and restore to every schema-v3 table, including all
  anti-forget context.
- Kept unsigned IPA distribution for sideloading without Apple certificates.

## 1.2.0 — Anti-lupa

- Added Idea Inbox to capture ideas without creating projects, sprints, or tasks.
- Added Restart Capsule for project state, last output, blocker, and next action.
- Added daily energy and available-time check-ins that guide plan sizing.
- Added deterministic automatic Recovery Mode using local project, sprint, plan,
  Ship, review, check-in, and capsule signals.
- Weekly reviews now apply continue, pivot, or park decisions transactionally.
- Added Drift schema v2 with additive migration for ideas, capsules, check-ins,
  and review decision audit timestamps.
- Added repository and domain tests for the integrated anti-forget loop.

## 1.1.0 — Stability

- Today refreshes across midnight and when the app resumes from background.
- Project reactivation starts a fresh sprint while preserving useful context.
- Replaced focus and archived projects no longer retain active sprints.
- App version metadata is shown consistently in Settings.
- Established an explicit Drift migration lifecycle.

## 1.0.1 — Focus Blue

- Replaced the warm paper, terracotta, and green-ink palette with cool-white
  surfaces, navy text, and one cobalt focus accent.
- Recolored the app icon, launch screen, and web chrome to use the same palette.
- Preserved every layout, interaction, route, data rule, and feature behavior.
- Revalidated text, control, status, and CTA contrast against WCAG targets.

## 1.0.0 — Versi 1

- A guided three-stage onboarding and focus setup flow that explains the daily
  rhythm before asking users to configure a project.
- A complete calm-editorial redesign across Today, Projects, Guides, Results,
  forms, loading states, empty states, and recovery flows.
- A clearer Today hierarchy with one required outcome, at most three actions,
  low-energy adaptations, and a direct Ship-to-evidence handoff.
- Friendlier project language for focus, maintenance, and parked ideas without
  changing the underlying local-first domain rules.
- Improved compact-iPhone and Dynamic Type behavior, route recovery,
  accessibility contrast, and actionable error states.
- Expanded responsive widget and repository coverage to 32 automated tests.
- Unsigned iOS IPA distribution for AltStore/Sideloadly re-signing; no Apple
  certificate or provisioning profile is embedded.

## 0.1.0 — MVP candidate

- One-focus project tracker with 30-day sprint and at most three daily actions.
- Ship Hari Ini with full and partial results, low-energy mode, and Lost Track recovery.
- Offline PDF library with metadata, search, reader, resume, thumbnails, bookmark, and notes.
- Daily evidence metrics, contextual project comparison, and weekly review decisions.
- Optional local reminders with permission education and Indonesian time zones.
- Flutter web preview for visual QA on Windows.
- Final iOS/web app icon set and branded off-white launch screen.
- App privacy manifest declaring no tracking or off-device data collection.
- Drift schema v1 baseline and migration validation tests.
- GitHub Actions workflows for tested unsigned and protected signed IPA builds.
