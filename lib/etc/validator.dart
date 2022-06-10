abstract class Validator {
  static bool passwordValidator(String password) {
    if (RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,25}$',
            unicode: true)
        .hasMatch(password)) return true;
    return false;
  }

  static bool usernameValidator(String username) {
    if (RegExp(r'^[0-9 A-z ؀-ۿ]{4,25}$', unicode: true).hasMatch(username))
      return true;
    return false;
  }

  static bool nameValidator(String name) {
    if (RegExp(
      r'^[A-z]{4,15}$',
    ).hasMatch(name)) return true;
    return false;
  }

  static bool emailValidator(String email) {
    if (RegExp(
      r'^(.+)@(\S+)$',
    ).hasMatch(email)) return true;
    return false;
  }

  static bool phoneValidator(String number) {
    if (RegExp(
      r'^[0-9]{9,15}$',
    ).hasMatch(number)) return true;
    return false;
  }
}
