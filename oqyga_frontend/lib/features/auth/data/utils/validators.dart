import 'package:oqyga_frontend/generated/l10n.dart';

class AppValidators {
  static String? validateEmpty(String? value, String errorMessage) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? validatePhone(String? value, S s) {
    if (value == null || value.trim().isEmpty) {
      return s.phoneEmpty;
    }

    final phoneRegex = RegExp(r'^\+7\d{10}$');

    if (!phoneRegex.hasMatch(value)) {
      return s.phoneFormat;
    }
    return null;
  }

  static String? validatePassword(String? value, S s) {
    if (value == null || value.isEmpty) {
      return s.passwordEmpty;
    }
    if (value.length < 8) {
      return s.passwordLength;
    }
    return null;
  }
}
