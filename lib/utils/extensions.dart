extension StringExtension on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidUsername {
    final usernameRegExp = RegExp(r"^[a-zA-Z0-9]{3,}$");
    return usernameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*[A-Za-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_,.?":{}|<>]).{8,}$'
    );
    return passwordRegExp.hasMatch(this);
  }


}
