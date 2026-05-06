// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get connectionTimeoutMessage =>
      'Connection timeout.\nPlease check your internet connection and try again.';

  @override
  String get sendTimeoutMessage =>
      'Request took too long to send.\nPlease try again.';

  @override
  String get receiveTimeoutMessage =>
      'Server took too long to respond.\nPlease try again later.';

  @override
  String get badCertificateMessage =>
      'Security certificate error.\nPlease try again later.';

  @override
  String get requestCancelledMessage => 'Request was cancelled.';

  @override
  String get connectionErrorMessage =>
      'No internet connection.\nPlease check your network.';

  @override
  String get unknownErrorMessage => 'Something went wrong.\nPlease try again.';

  @override
  String get unexpectedErrorMessage =>
      'Unexpected error occurred.\nPlease try again.';

  @override
  String get errors_error400 => 'Bad request.';

  @override
  String get errors_error401 => 'Unauthorized access.';

  @override
  String get errors_error403 => 'Forbidden request.';

  @override
  String get errors_error404 => 'Resource not found.';

  @override
  String get errors_error408 => 'Request timeout.';

  @override
  String get errors_error429 => 'Too many requests. Please try again later.';

  @override
  String get errors_error500 => 'Internal server error.';

  @override
  String get errors_error502 => 'Bad gateway.';

  @override
  String get errors_error503 => 'Service unavailable.';

  @override
  String get errors_error504 => 'Gateway timeout.';

  @override
  String get errors_defaultError => 'An error occurred. Please try again.';

  @override
  String get login => 'Login';
}
