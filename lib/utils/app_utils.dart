class AppUtils{
  static bool isPasswordValid(String password, [int minLength = 6]) {
    bool hasUppercase = password.contains( RegExp(r'[A-Z]'));
    bool hasDigits = password.contains( RegExp(r'[0-9]'));
    bool hasLowercase = password.contains( RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
    password.contains( RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;
    return hasDigits &
    //hasUppercase &
    hasLowercase &
    hasSpecialCharacters &
    hasMinLength;
  }
}