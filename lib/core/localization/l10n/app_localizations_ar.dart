// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get connectionTimeoutMessage =>
      'انتهت مهلة الاتصال.\nيرجى التحقق من الإنترنت والمحاولة مرة أخرى.';

  @override
  String get sendTimeoutMessage =>
      'استغرق إرسال الطلب وقتًا طويلاً.\nيرجى المحاولة مرة أخرى.';

  @override
  String get receiveTimeoutMessage =>
      'استغرق الخادم وقتًا طويلاً في الرد.\nيرجى المحاولة لاحقًا.';

  @override
  String get badCertificateMessage =>
      'خطأ في شهادة الأمان.\nيرجى المحاولة لاحقًا.';

  @override
  String get requestCancelledMessage => 'تم إلغاء الطلب.';

  @override
  String get connectionErrorMessage =>
      'لا يوجد اتصال بالإنترنت.\nيرجى التحقق من الشبكة.';

  @override
  String get unknownErrorMessage => 'حدث خطأ ما.\nيرجى المحاولة مرة أخرى.';

  @override
  String get unexpectedErrorMessage =>
      'حدث خطأ غير متوقع.\nيرجى المحاولة مرة أخرى.';

  @override
  String get errors_error400 => 'طلب غير صالح.';

  @override
  String get errors_error401 => 'غير مصرح لك.';

  @override
  String get errors_error403 => 'تم رفض الطلب.';

  @override
  String get errors_error404 => 'العنصر غير موجود.';

  @override
  String get errors_error408 => 'انتهت مهلة الطلب.';

  @override
  String get errors_error429 => 'طلبات كثيرة جدًا. حاول لاحقًا.';

  @override
  String get errors_error500 => 'خطأ في الخادم.';

  @override
  String get errors_error502 => 'بوابة غير صالحة.';

  @override
  String get errors_error503 => 'الخدمة غير متاحة.';

  @override
  String get errors_error504 => 'انتهت مهلة البوابة.';

  @override
  String get errors_defaultError => 'حدث خطأ. حاول مرة أخرى.';

  @override
  String get login => 'تسجيل الدخول';
}
