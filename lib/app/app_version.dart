abstract final class AppVersion {
  static const name = String.fromEnvironment(
    'SATU_DULU_VERSION',
    defaultValue: '1.2.0',
  );

  static const build = String.fromEnvironment(
    'SATU_DULU_BUILD',
    defaultValue: '4',
  );

  static String get display => '$name+$build';
}
