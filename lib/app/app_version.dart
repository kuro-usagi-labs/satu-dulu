abstract final class AppVersion {
  static const name = String.fromEnvironment(
    'SATU_DULU_VERSION',
    defaultValue: '1.2.1',
  );

  static const build = String.fromEnvironment(
    'SATU_DULU_BUILD',
    defaultValue: '5',
  );

  static String get display => '$name+$build';
}
