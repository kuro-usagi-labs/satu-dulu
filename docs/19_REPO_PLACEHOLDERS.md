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
VERSION_NAME=1.0.1
BUILD_NUMBER=2
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
- app icon: cobalt focus mark di atas cool-white;
- primary accent: `#F25926`;
- reminder defaults: tersimpan lokal dan dapat diubah pengguna;
- distribusi `v1.0.1`: IPA unsigned untuk ditandatangani ulang oleh tooling sideload;
- signed GitHub workflow dan App Store distribution tidak digunakan untuk rilis ini;
- widget tidak termasuk MVP.

## Repository integration checklist

- [x] User provides GitHub URL.
- [x] Replace repository, package, and bundle placeholders.
- [x] Add docs pack to root.
- [ ] Add branch protection.
- [x] Configure least-privilege permissions in workflow files.
- [x] Create reserved `ios-build` environment; tidak digunakan pada `v0.1.0`.
- [x] Leave signing secrets unset because the owner chose sideload distribution.
- [x] Run bootstrap and implement the MVP roadmap.
