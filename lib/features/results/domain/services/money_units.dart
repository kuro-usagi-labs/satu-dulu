import 'package:intl/intl.dart';

abstract final class MoneyUnits {
  static final _formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  static int? rupiahTextToMinor(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return null;
    return int.parse(digits) * 100;
  }

  static String formatMinor(num minor) => _formatter.format(minor / 100);
}
