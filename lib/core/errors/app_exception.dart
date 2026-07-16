sealed class AppException implements Exception {
  const AppException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() => message;
}

final class ValidationException extends AppException {
  const ValidationException(super.message);
}

final class DatabaseException extends AppException {
  const DatabaseException(super.message, [super.cause]);
}

final class FileImportException extends AppException {
  const FileImportException(super.message, [super.cause]);
}

final class PdfReadException extends AppException {
  const PdfReadException(super.message, [super.cause]);
}

final class PermissionException extends AppException {
  const PermissionException(super.message, [super.cause]);
}
