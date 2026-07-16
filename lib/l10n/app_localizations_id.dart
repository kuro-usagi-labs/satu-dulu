// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get todayTab => 'Hari Ini';

  @override
  String get projectsTab => 'Proyek';

  @override
  String get guidesTab => 'Panduan';

  @override
  String get resultsTab => 'Hasil';

  @override
  String get todayTitle => 'Hari Ini';

  @override
  String get todaySubtitle => 'Satu arah yang jelas untuk hari ini.';

  @override
  String get noFocusTitle => 'Belum ada fokus utama';

  @override
  String get noFocusDescription =>
      'Pilih satu proyek untuk eksperimen 30 hari. Ide lain tetap aman di Parking Lot.';

  @override
  String get createFirstFocus => 'Buat fokus pertama';

  @override
  String get projectsTitle => 'Proyek';

  @override
  String get projectsSubtitle => 'Fokus, maintenance, dan Parking Lot milikmu.';

  @override
  String get noProjectsTitle => 'Mulai dari satu proyek';

  @override
  String get noProjectsDescription =>
      'Tuliskan tujuan dan alasan kenapa proyek ini layak mendapat perhatianmu sekarang.';

  @override
  String get createProject => 'Buat proyek';

  @override
  String get guidesTitle => 'Panduan';

  @override
  String get guidesSubtitle =>
      'Petunjuk yang bisa dibuka lagi saat kehilangan arah.';

  @override
  String get noGuidesTitle => 'Belum ada panduan';

  @override
  String get noGuidesDescription =>
      'PDF yang diimpor nanti akan tersimpan lokal dan tetap bisa dibaca offline.';

  @override
  String get addGuide => 'Tambahkan panduan';

  @override
  String get resultsTitle => 'Hasil';

  @override
  String get resultsSubtitle =>
      'Lihat bukti eksperimen, bukan sekadar kesibukan.';

  @override
  String get noResultsTitle => 'Belum ada hasil tercatat';

  @override
  String get noResultsDescription =>
      'Setelah kamu ship, output dan metrik sederhana akan muncul di sini.';

  @override
  String get recordResult => 'Catat hasil hari ini';
}
