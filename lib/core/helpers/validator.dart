import '../values/app_strings.dart';

abstract class Validator {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emptyField;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired;
    }
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]',
    );
    if (!passwordRegex.hasMatch(value)) {
      return AppStrings.passwordValid;
    }

    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.confirmPasswordRequired;
    }
    if (value != password) {
      return AppStrings.passwordsNotMatch;
    }
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]',
    );
    if (!passwordRegex.hasMatch(value)) {
      return AppStrings.passwordValid;
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.phoneRequired;
    }

    value = value.trim();

    // final phoneRegex = RegExp(r'^\d{9}$');
    //
    // if (!phoneRegex.hasMatch(value)) {
    //   return AppStrings.phoneInvalid;
    // }

    return null;
  }
}
