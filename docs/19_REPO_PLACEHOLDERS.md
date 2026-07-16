# Repository Placeholders

Ganti nilai berikut setelah repository dan Apple configuration tersedia.

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

## Decisions still open

- minimum iOS version confirmation;
- app icon;
- primary accent color confirmation;
- exact reminder default hours;
- signed build type: development or ad-hoc;
- whether App Store distribution is planned;
- whether P1 widget is included before first private release.

## Repository integration checklist

- [x] User provides GitHub URL.
- [ ] Replace placeholders.
- [ ] Add docs pack to root.
- [ ] Add branch protection.
- [ ] Configure Actions permissions.
- [ ] Create `ios-build` environment.
- [ ] Add signing secrets only if signed IPA needed.
- [ ] Run bootstrap prompt.
