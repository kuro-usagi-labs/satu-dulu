# GitHub Actions — Flutter and iOS Build

## Goals

1. Validate every pull request.
2. Build unsigned IPA artifact for sideload re-signing tools.
3. Optionally build signed development/ad-hoc IPA.
4. Keep Apple credentials out of repository.

## Workflow A — Pull request CI

Recommended file later: `.github/workflows/ci.yml`

```yaml
name: Flutter CI

on:
  pull_request:
  push:
    branches: [main]

permissions:
  contents: read

jobs:
  test:
    runs-on: ubuntu-latest
    timeout-minutes: 20

    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - run: flutter pub get
      - run: dart format --output=none --set-exit-if-changed .
      - run: flutter analyze
      - run: flutter test --coverage
```

Pin third-party actions to commit SHA for stricter supply-chain security when repository matures.

## Workflow B — Unsigned IPA artifact

Purpose: menghasilkan iOS app bundle tanpa Apple signing, lalu membungkusnya sebagai IPA-like artifact untuk alat sideload yang melakukan signing ulang.

Recommended file later: `.github/workflows/ios-unsigned.yml`

```yaml
name: Build Unsigned iOS IPA

on:
  workflow_dispatch:
  push:
    tags:
      - 'v*'

permissions:
  contents: read

jobs:
  build:
    runs-on: macos-15
    timeout-minutes: 45

    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test

      - name: Build iOS app without codesign
        run: flutter build ios --release --no-codesign

      - name: Package unsigned IPA
        run: |
          mkdir -p Payload
          cp -R build/ios/iphoneos/Runner.app Payload/Runner.app
          ditto -c -k --sequesterRsrc --keepParent Payload SatuDulu-unsigned.ipa

      - uses: actions/upload-artifact@v4
        with:
          name: satu-dulu-unsigned-ipa
          path: SatuDulu-unsigned.ipa
          if-no-files-found: error
```

Catatan: artifact unsigned tidak dapat langsung dijalankan di perangkat tanpa proses signing/re-signing yang sesuai.

## Workflow C — Signed IPA

Use only when Apple signing material is prepared.

Secrets:

```text
IOS_CERTIFICATE_BASE64
IOS_CERTIFICATE_PASSWORD
IOS_PROVISIONING_PROFILE_BASE64
KEYCHAIN_PASSWORD
EXPORT_OPTIONS_PLIST_BASE64
```

Optional variables:

```text
IOS_BUNDLE_ID
APPLE_TEAM_ID
```

Recommended outline:

```yaml
name: Build Signed iOS IPA

on:
  workflow_dispatch:

permissions:
  contents: read

jobs:
  build:
    runs-on: macos-15
    environment: ios-build
    timeout-minutes: 45

    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - name: Install signing assets
        env:
          CERTIFICATE_BASE64: ${{ secrets.IOS_CERTIFICATE_BASE64 }}
          P12_PASSWORD: ${{ secrets.IOS_CERTIFICATE_PASSWORD }}
          PROVISIONING_PROFILE_BASE64: ${{ secrets.IOS_PROVISIONING_PROFILE_BASE64 }}
          KEYCHAIN_PASSWORD: ${{ secrets.KEYCHAIN_PASSWORD }}
          EXPORT_OPTIONS_BASE64: ${{ secrets.EXPORT_OPTIONS_PLIST_BASE64 }}
        run: |
          CERTIFICATE_PATH=$RUNNER_TEMP/build_certificate.p12
          PP_PATH=$RUNNER_TEMP/build_pp.mobileprovision
          KEYCHAIN_PATH=$RUNNER_TEMP/app-signing.keychain-db

          echo -n "$CERTIFICATE_BASE64" | base64 --decode -o "$CERTIFICATE_PATH"
          echo -n "$PROVISIONING_PROFILE_BASE64" | base64 --decode -o "$PP_PATH"
          echo -n "$EXPORT_OPTIONS_BASE64" | base64 --decode -o ios/ExportOptions.plist

          security create-keychain -p "$KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"
          security set-keychain-settings -lut 21600 "$KEYCHAIN_PATH"
          security unlock-keychain -p "$KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"
          security import "$CERTIFICATE_PATH" -P "$P12_PASSWORD" -A -t cert -f pkcs12 -k "$KEYCHAIN_PATH"
          security list-keychain -d user -s "$KEYCHAIN_PATH"

          mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
          cp "$PP_PATH" ~/Library/MobileDevice/Provisioning\ Profiles/build_pp.mobileprovision

      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test

      - name: Build signed IPA
        run: flutter build ipa --release --export-options-plist=ios/ExportOptions.plist

      - uses: actions/upload-artifact@v4
        with:
          name: satu-dulu-signed-ipa
          path: build/ios/ipa/*.ipa
          if-no-files-found: error

      - name: Cleanup keychain
        if: always()
        run: security delete-keychain "$RUNNER_TEMP/app-signing.keychain-db" || true
```

Codex must validate commands against the generated Xcode project and current runner image.

## ExportOptions patterns

Development example concept:

```xml
<key>method</key>
<string>development</string>
<key>signingStyle</key>
<string>manual</string>
<key>teamID</key>
<string>APPLE_TEAM_ID</string>
```

Ad-hoc uses method appropriate to the Xcode version/toolchain and a provisioning profile containing registered device IDs. Generate this file from Xcode export when possible rather than guessing every key.

## Security rules

- never print decoded secrets;
- use environment protection for signed build;
- signed build should be manual initially;
- do not run signed builds on untrusted pull request code;
- use least `GITHUB_TOKEN` permissions;
- artifact retention should be intentional;
- rotate certificate/password if exposure is suspected.

## Repository URL

Use placeholder until user provides:

```text
https://github.com/<GITHUB_USERNAME>/<REPOSITORY_NAME>
```

No documentation depends on a concrete URL.
