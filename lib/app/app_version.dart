abstract final class AppVersion {
  static const name = String.fromEnvironment(
    'SATU_DULU_VERSION',
    defaultValue: '1.1.0',
  );

  static const build = String.fromEnvironment(
    'SATU_DULU_BUILD',
    defaultValue: '3',
  );

  static String get display => '$name+$build';
}
