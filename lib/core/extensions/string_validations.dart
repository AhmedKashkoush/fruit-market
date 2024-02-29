extension StringValidation on String {
  bool get isEmail {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
    return emailValid;
  }

  bool get isPhone {
    final bool phoneValid = RegExp(r'^\+(?:\d\s?){6,14}\d$').hasMatch(this);
    return phoneValid;
  }
}
