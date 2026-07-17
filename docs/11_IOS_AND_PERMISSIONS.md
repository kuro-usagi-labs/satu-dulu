# iOS Integration and Permissions

## Deployment target

Target awal: iOS 16+.

Alasan produk:

- cakupan perangkat masih luas;
- API modern cukup tersedia;
- mengurangi kompleksitas compatibility dibanding target sangat lama.

Nilai ini dapat diubah sebelum implementation freeze.

## Bundle and signing

```text
Bundle ID: com.kurogi.satudulu
Display Name: Satu Dulu
Team ID: <APPLE_TEAM_ID>
```

## File import

Gunakan native document picker melalui plugin Flutter.

Requirements:

- hanya filter PDF;
- akses source digunakan untuk copy;
- jangan menyimpan reference source sebagai satu-satunya lokasi;
- copy ke app documents;
- handle iCloud download delay;
- handle canceled picker tanpa error;
- handle file provider failures.

## App storage

- persistent PDFs: Application Documents;
- cache thumbnails: Application Support or Cache sesuai kebutuhan;
- temporary import: Temporary directory;
- relative path disimpan di database;
- jangan hardcode absolute sandbox path karena dapat berubah.

## Notifications

Permission flow:

1. jelaskan manfaat reminder di UI;
2. user memilih enable;
3. baru request system permission;
4. jika denied, settings tetap bisa diubah dan ada link ke system settings.

Local notification categories MVP tidak membutuhkan remote push.

## Background behavior

MVP tidak memerlukan background processing kompleks. Local notifications dijadwalkan dari app.

## App lifecycle

- flush pending last-page update on pause;
- database connection managed centrally;
- restore selected tab and navigation safely;
- avoid re-showing onboarding after completion.

## App icon and launch screen

Release candidate menggunakan:

- app icon lengkap untuk seluruh ukuran iPhone, iPad, dan App Store;
- background launch screen cool-white `#F6F8FC`;
- centered minimal mark tanpa copy marketing;
- generator deterministik di `tool/generate_app_icons.ps1`.

## Privacy manifest and package review

Target Runner menyertakan `PrivacyInfo.xcprivacy` yang menyatakan aplikasi tidak melakukan tracking atau pengumpulan data keluar perangkat. Plugin iOS tetap wajib membawa deklarasi required-reason API masing-masing; audit plugin diulang setiap dependency berubah.

## Device testing

Minimum manual matrix:

- smallest supported iPhone width;
- modern standard iPhone;
- Pro Max size;
- light mode;
- portrait and PDF landscape;
- notification denied and allowed;
- low storage simulation where possible;
- file from iCloud provider.
