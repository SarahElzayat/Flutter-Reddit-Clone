class Validator {
  /// this is a utility function which detects whethere the password length
  /// is enough or not.
  static bool validPasswordValidation(String password) {
    if (password.isEmpty || password.length < 8) {
      return false;
    }

    return true;
  }

  /// this function returns [True] if the email matches this regular expression
  /// and it returns [False] otherwise.
  static bool validEmailValidator(String email) {
    return email.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
  }

  /// this function returns [True] if the username is valid
  /// which is valid in this case
  /// 1- if it is not empty.
  /// and it returns [False] otherwise.
  static bool validUserName(String username) {
    return username.isNotEmpty && (username.length > 3 && username.length < 20);
  }
}
