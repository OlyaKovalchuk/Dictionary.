
const ERROR_WEAK_PASSWORD = 'weak-password';
const ERROR_EMAIL_ALREADY_IN_USE = 'email-already-in-use';
const ERROR_UID_ALREADY_EXISTS = 'auth/uid-already-exists';
const ERROR_USER_NOT_FOUND = 'user-not-found';
const ERROR_WRONG_PASSWORD = 'wrong-password';

checkError(String exception) {
  if (exception == ERROR_USER_NOT_FOUND) {
    print('No user found for that email.');
    String error = 'No user found for that email.';
    return  error;
  } else if (exception == ERROR_WRONG_PASSWORD) {
    print('Wrong password provided for that user.');
    String error = 'Wrong password provided for that user.';
    return  error;
  } else if (exception == ERROR_UID_ALREADY_EXISTS) {
    print('The account already exists for that uid.');
    String error = 'The account already exists for that uid.';
    return  error;
  } else if (exception == ERROR_EMAIL_ALREADY_IN_USE) {
    print('The account already exists for that email.');
    String error = 'The account already exists for that email.';
    return  error;
  } else if (exception == ERROR_WEAK_PASSWORD) {
    print('The account already exists for that email.');
    String error = 'The account already exists for that email.';
    return  error;
  }
}
