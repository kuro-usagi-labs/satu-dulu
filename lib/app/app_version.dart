abstract final class AppVersion {
  static const name = String.fromEnvironment(
    'SATU_DULU_VERSION',
    defaultValue: '1.2.2',
  );

  static const build = String.fromEnvironment(
    'SATU_DULU_BUILD',
    defaultValue: '6',
  );

  static String get display => '$name+$build';
}
