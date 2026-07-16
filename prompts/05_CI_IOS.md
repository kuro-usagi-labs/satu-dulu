# Codex Prompt — GitHub Actions iOS

```text
Read AGENTS.md, docs/11_IOS_AND_PERMISSIONS.md, docs/12_GITHUB_ACTIONS_IOS.md, docs/13_SECURITY_PRIVACY.md, and docs/19_REPO_PLACEHOLDERS.md.

Implement GitHub Actions workflows:
1. PR/push Flutter CI on Ubuntu: format, analyze, test.
2. Manual/tag unsigned iOS IPA build on a current supported macOS runner.
3. Optional signed IPA manual workflow using protected environment and repository secrets.

Do not hardcode certificate data, passwords, team ID, or provisioning files.
Use least permissions and cleanup temporary keychains.
Validate Flutter and Xcode commands against the generated project.
Document every required GitHub secret and manual setup step in the repository README.

If signing inputs are unavailable, complete and test the unsigned workflow and leave the signed workflow safely disabled or manual-only with clear placeholders.
```
