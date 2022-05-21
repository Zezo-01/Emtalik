abstract class Validator {
  static bool passwordValidator(String password) {
    if (RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,25}$',
    ).hasMatch(password)) return true;
    return false;
  }
}
// TODO: implmenet name and email validator