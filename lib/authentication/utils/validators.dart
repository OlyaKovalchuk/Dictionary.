class Validators {
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static String? validEmail(String? email) {
    if (email == '') {
      return 'Email is required';
    } else if (!isValidEmail(email!)) {
      return 'Please enter your email correctly';
    }
  }

  static bool isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static String? validPassword(String? password) {
    {
      if (password == '') {
        return 'Password is required';
      } else {
        if (!isValidPassword(password!)) {
          return 'Please enter your password correctly';
        }
      }
    }
  }

  static String? validName(String? name) {
    if (name == '') {
      return 'Name is required';
    }
  }
}
