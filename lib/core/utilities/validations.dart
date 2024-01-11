import 'package:easy_localization/easy_localization.dart';
import 'package:kafil/generated/locale_keys.g.dart';

extension FieldValidate on String {
  String? validate(List<String? Function(String?)> functions) {
    for (final String? Function(String?) func in functions) {
      final result = func(this);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}

String? validateRequired(String? value) {
  return value!.trim().isEmpty ? LocaleKeys.errors_required.tr() : null;
}

String? validateName(String? value) {
  return value!.length > 50 ? LocaleKeys.errors_invalid_username.tr() : null;
}

String? matchesPasswords(String? password, String? confirmPassword) {
  return password != confirmPassword
      ? LocaleKeys.errors_invalid_password.tr()
      : null;
}

String? validateEmail(String? value) {
  const pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regExp = RegExp(pattern);
  if (!regExp.hasMatch(value!)) {
    return LocaleKeys.errors_invalid_email.tr();
  }
  return null;
}

String? validatePhone(String? value) {
  const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  final regExp = RegExp(pattern);
  if (!regExp.hasMatch(value!)) {
    return LocaleKeys.errors_invalid_phone;
  }
  return null;
}

String? validateAbout(String? value) {
  if (value!.length < 10) {
    return LocaleKeys.errors_weak_about.tr();
  } else if (value.length > 1000) {
    return LocaleKeys.errors_strong_about.tr();
  }

  return null;
}

String? validatePassword(String? password) {
  final hasLength = password!.length >= 8;

  if (!hasLength) {
    return LocaleKeys.errors_invalid_password.tr();
  }

  return null;
}
