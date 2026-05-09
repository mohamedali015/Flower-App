import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @connectionTimeoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout.\nPlease check your internet connection and try again.'**
  String get connectionTimeoutMessage;

  /// No description provided for @sendTimeoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Request took too long to send.\nPlease try again.'**
  String get sendTimeoutMessage;

  /// No description provided for @receiveTimeoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Server took too long to respond.\nPlease try again later.'**
  String get receiveTimeoutMessage;

  /// No description provided for @badCertificateMessage.
  ///
  /// In en, this message translates to:
  /// **'Security certificate error.\nPlease try again later.'**
  String get badCertificateMessage;

  /// No description provided for @requestCancelledMessage.
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled.'**
  String get requestCancelledMessage;

  /// No description provided for @connectionErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.\nPlease check your network.'**
  String get connectionErrorMessage;

  /// No description provided for @unknownErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.\nPlease try again.'**
  String get unknownErrorMessage;

  /// No description provided for @unexpectedErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred.\nPlease try again.'**
  String get unexpectedErrorMessage;

  /// No description provided for @errors_error400.
  ///
  /// In en, this message translates to:
  /// **'Bad request.'**
  String get errors_error400;

  /// No description provided for @errors_error401.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized access.'**
  String get errors_error401;

  /// No description provided for @errors_error403.
  ///
  /// In en, this message translates to:
  /// **'Forbidden request.'**
  String get errors_error403;

  /// No description provided for @errors_error404.
  ///
  /// In en, this message translates to:
  /// **'Resource not found.'**
  String get errors_error404;

  /// No description provided for @errors_error408.
  ///
  /// In en, this message translates to:
  /// **'Request timeout.'**
  String get errors_error408;

  /// No description provided for @errors_error429.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please try again later.'**
  String get errors_error429;

  /// No description provided for @errors_error500.
  ///
  /// In en, this message translates to:
  /// **'Internal server error.'**
  String get errors_error500;

  /// No description provided for @errors_error502.
  ///
  /// In en, this message translates to:
  /// **'Bad gateway.'**
  String get errors_error502;

  /// No description provided for @errors_error503.
  ///
  /// In en, this message translates to:
  /// **'Service unavailable.'**
  String get errors_error503;

  /// No description provided for @errors_error504.
  ///
  /// In en, this message translates to:
  /// **'Gateway timeout.'**
  String get errors_error504;

  /// No description provided for @errors_defaultError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get errors_defaultError;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
