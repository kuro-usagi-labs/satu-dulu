# Flutter Architecture

## Stack

- Flutter stable channel;
- Dart bundled with Flutter;
- Riverpod for state management and dependency injection;
- go_router for navigation;
- Drift + SQLite for local persistence;
- file_picker for PDF import;
- path_provider + dart:io for storage;
- pdfrx for rendering;
- flutter_local_notifications for reminders;
- uuid for identifiers;
- crypto for optional checksum;
- archive for deterministic local backup ZIP;
- intl for localized formatting;
- share_plus for export/share later.

Version numbers should be pinned when implementation starts and updated intentionally.

## Architecture style

Feature-first with layered boundaries.

```text
lib/
├── app/
│   ├── app.dart
│   ├── bootstrap.dart
│   ├── router/
│   └── theme/
├── core/
│   ├── database/
│   ├── errors/
│   ├── files/
│   ├── notifications/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── onboarding/
│   ├── today/
│   ├── projects/
│   ├── sprints/
│   ├── lost_track/
│   ├── guides/
│   ├── pdf_reader/
│   ├── metrics/
│   ├── reviews/
│   └── settings/
└── main.dart
```

Inside a feature:

```text
feature/
├── data/
│   ├── datasources/
│   ├── dtos/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── controllers/
    ├── screens/
    └── widgets/
```

Tidak semua fitur harus memiliki boilerplate berlebihan. Gunakan layers saat ada business logic nyata.

## State approach

- repository providers bersifat long-lived;
- screen controller menggunakan AsyncNotifier/Notifier sesuai kebutuhan;
- transient local UI state dapat tetap di StatefulWidget/hooks;
- no database call from build method;
- streams digunakan untuk list reactive;
- mutation mengembalikan typed result atau melempar app-specific exception yang dipetakan di controller.

## Navigation

Routes:

```text
/onboarding
/today
/projects
/projects/new
/projects/:projectId
/projects/:projectId/cycle-review
/guides
/guides/import
/guides/:documentId
/guides/:documentId/read
/results
/reviews/new
/settings
```

Gunakan StatefulShellRoute atau equivalent agar tab state dan scroll position dipertahankan.

## Theme

Buat semantic tokens:

- AppColors;
- AppSpacing;
- AppRadius;
- AppDuration;
- AppTextStyles;
- AppShadows.

Components tidak boleh memakai hex random langsung kecuali token definition.

## File service

`GuideFileService` responsibilities:

- create PDF directory;
- import/copy file;
- validate file existence;
- calculate optional checksum;
- delete local file;
- resolve absolute path from relative path;
- clean orphan files.

Repository transaction mengkoordinasikan file + database dengan compensating cleanup.

`LocalBackupCoordinator` mengoordinasikan snapshot repository, archive codec,
native file picker, staging PDF, dan compensating rollback. Presentation tidak
menyentuh database atau path sandbox secara langsung.

## Error model

```dart
sealed class AppFailure {
  const AppFailure();
}

final class ValidationFailure extends AppFailure {}
final class DatabaseFailure extends AppFailure {}
final class FileImportFailure extends AppFailure {}
final class PdfReadFailure extends AppFailure {}
final class PermissionFailure extends AppFailure {}
```

User-facing copy tidak menampilkan stack trace.

## Localization

MVP UI Bahasa Indonesia, tetapi string tetap ditempatkan pada localization resources agar English dapat ditambahkan nanti.

## Performance

- lazy list;
- thumbnail generation asynchronous;
- PDF reader page cache sesuai library;
- database indexes untuk status, projectId, lastOpenedAt, importedAt;
- debounce search and last page writes;
- avoid rebuilding entire Today screen for timer ticks;
- use const widgets where possible.
