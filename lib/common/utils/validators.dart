import 'package:reimink_zwembaden_admin/common/resources/resources.dart';

class InputValidator {
  InputValidator._();

  static String? emailValidator(String? email) {
    if (email == null || email.trim().isEmpty) {
      return Strings.emailRequired;
    } else {
      bool isEmailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (!isEmailValid) return Strings.invalidEmail;
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.trim().isEmpty) {
      return Strings.passwordRequired;
    } else if (password.trim().length < 6) {
      return Strings.passwordLengthValidationMessage;
    }
    return null;
  }

  static String? requiredFieldValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return Strings.emptyFieldValidatorErrorMessage;
    }
    return null;
  }
}

class Validator {
  Validator._();

  static bool validateEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(
      email.trim(),
    );
  }

  static bool validatePassword(String password) {
    return password.length > 5;
  }
}
