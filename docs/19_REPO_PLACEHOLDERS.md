# Repository Configuration

Nilai repository dan identitas aplikasi sudah diputuskan. Hanya material signing Apple yang tetap dikelola di luar repository.

## GitHub

```text
GITHUB_USERNAME=kuro-usagi-labs
REPOSITORY_NAME=satu-dulu
REPOSITORY_URL=https://github.com/kuro-usagi-labs/satu-dulu
```

## App identity

```text
APP_DISPLAY_NAME=Satu Dulu
DART_PACKAGE_NAME=satu_dulu
IOS_BUNDLE_ID=com.kurogi.satudulu
APPLE_TEAM_ID=<replace>
```

## App version

```text
VERSION_NAME=0.1.0
BUILD_NUMBER=1
```

## Signing secrets

Create in GitHub repository/environment, never in files:

```text
IOS_CERTIFICATE_BASE64
IOS_CERTIFICATE_PASSWORD
IOS_PROVISIONING_PROFILE_BASE64
KEYCHAIN_PASSWORD
EXPORT_OPTIONS_PLIST_BASE64
```

## Decisions

- minimum iOS version: iOS 16+;
- app icon: cobalt focus mark di atas off-white;
- primary accent: `#4468F2`;
- reminder defaults: tersimpan lokal dan dapat diubah pengguna;
- signed build type: development or ad-hoc;
- whether App Store distribution is planned;
- widget tidak termasuk MVP.

## Repository integration checklist

- [x] User provides GitHub URL.
- [x] Replace repository, package, and bundle placeholders.
- [x] Add docs pack to root.
- [ ] Add branch protection.
- [x] Configure least-privilege permissions in workflow files.
- [ ] Create `ios-build` environment.
- [ ] Add signing secrets only if signed IPA needed.
- [x] Run bootstrap and implement the MVP roadmap.
