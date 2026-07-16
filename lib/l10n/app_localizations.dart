import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('id')];

  /// No description provided for @todayTab.
  ///
  /// In id, this message translates to:
  /// **'Hari Ini'**
  String get todayTab;

  /// No description provided for @projectsTab.
  ///
  /// In id, this message translates to:
  /// **'Proyek'**
  String get projectsTab;

  /// No description provided for @guidesTab.
  ///
  /// In id, this message translates to:
  /// **'Panduan'**
  String get guidesTab;

  /// No description provided for @resultsTab.
  ///
  /// In id, this message translates to:
  /// **'Hasil'**
  String get resultsTab;

  /// No description provided for @todayTitle.
  ///
  /// In id, this message translates to:
  /// **'Hari Ini'**
  String get todayTitle;

  /// No description provided for @todaySubtitle.
  ///
  /// In id, this message translates to:
  /// **'Satu arah yang jelas untuk hari ini.'**
  String get todaySubtitle;

  /// No description provided for @noFocusTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada fokus utama'**
  String get noFocusTitle;

  /// No description provided for @noFocusDescription.
  ///
  /// In id, this message translates to:
  /// **'Pilih satu proyek untuk eksperimen 30 hari. Ide lain tetap aman di Parking Lot.'**
  String get noFocusDescription;

  /// No description provided for @createFirstFocus.
  ///
  /// In id, this message translates to:
  /// **'Buat fokus pertama'**
  String get createFirstFocus;

  /// No description provided for @projectsTitle.
  ///
  /// In id, this message translates to:
  /// **'Proyek'**
  String get projectsTitle;

  /// No description provided for @projectsSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Fokus, maintenance, dan Parking Lot milikmu.'**
  String get projectsSubtitle;

  /// No description provided for @noProjectsTitle.
  ///
  /// In id, this message translates to:
  /// **'Mulai dari satu proyek'**
  String get noProjectsTitle;

  /// No description provided for @noProjectsDescription.
  ///
  /// In id, this message translates to:
  /// **'Tuliskan tujuan dan alasan kenapa proyek ini layak mendapat perhatianmu sekarang.'**
  String get noProjectsDescription;

  /// No description provided for @createProject.
  ///
  /// In id, this message translates to:
  /// **'Buat proyek'**
  String get createProject;

  /// No description provided for @guidesTitle.
  ///
  /// In id, this message translates to:
  /// **'Panduan'**
  String get guidesTitle;

  /// No description provided for @guidesSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Petunjuk yang bisa dibuka lagi saat kehilangan arah.'**
  String get guidesSubtitle;

  /// No description provided for @noGuidesTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada panduan'**
  String get noGuidesTitle;

  /// No description provided for @noGuidesDescription.
  ///
  /// In id, this message translates to:
  /// **'PDF yang diimpor nanti akan tersimpan lokal dan tetap bisa dibaca offline.'**
  String get noGuidesDescription;

  /// No description provided for @addGuide.
  ///
  /// In id, this message translates to:
  /// **'Tambahkan panduan'**
  String get addGuide;

  /// No description provided for @resultsTitle.
  ///
  /// In id, this message translates to:
  /// **'Hasil'**
  String get resultsTitle;

  /// No description provided for @resultsSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Lihat bukti eksperimen, bukan sekadar kesibukan.'**
  String get resultsSubtitle;

  /// No description provided for @noResultsTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada hasil tercatat'**
  String get noResultsTitle;

  /// No description provided for @noResultsDescription.
  ///
  /// In id, this message translates to:
  /// **'Setelah kamu ship, output dan metrik sederhana akan muncul di sini.'**
  String get noResultsDescription;

  /// No description provided for @recordResult.
  ///
  /// In id, this message translates to:
  /// **'Catat hasil hari ini'**
  String get recordResult;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
