const ERROR_WEAK_PASSWORD = 'weak-password';
const ERROR_EMAIL_ALREADY_IN_USE = 'email-already-exists';
const ERROR_UID_ALREADY_EXISTS = 'auth/uid-already-exists';
const ERROR_USER_NOT_FOUND = 'user-not-found';
const ERROR_INVALID_PASSWORD = 'invalid-password';
const ERROR_WRONG_PASSWORD = 'wrong-password';
const ERROR_INVALID_EMAIL = 'invalid-email';
const ERROR_TOO_MANY_REQUEST = 'too-many-requests';
const ERROR_UNKNOWN = 'unknown';

checkError(String exception) {
  String? error;
  if (exception == ERROR_USER_NOT_FOUND) {
    print('No user found for that email.');
    error = 'No user found for that email.';
    return error;
  } else if (exception == ERROR_WRONG_PASSWORD) {
    print('Wrong password provided for that user.');
    error = 'The password is wrong. Please enter correct password.';
    return error;
  } else if (exception == ERROR_UID_ALREADY_EXISTS) {
    print('The account already exists for that uid.');
    error = 'The account already exists for that uid.';
    return error;
  } else if (exception == ERROR_EMAIL_ALREADY_IN_USE) {
    print('The account already exists for that email.');
    error = 'The account already exists for that email.';
    return error;
  } else if (exception == ERROR_WEAK_PASSWORD) {
    print('The password is too weak.');
    error = 'The account already exists for that email.';
    return error;
  } else if (exception == ERROR_INVALID_EMAIL) {
    error = 'The email address is badly formatted.';
    return error;
  } else if (exception == ERROR_TOO_MANY_REQUEST) {
    error = 'Too many request.  Please try later';
    return error;
  } else if (exception == ERROR_INVALID_PASSWORD) {
    error = 'The password is badly formatted.';
    return error;
  } else {
    error = 'An error has occurred.  Try again';
    return error;
  }
}
