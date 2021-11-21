const ERROR_WEAK_PASSWORD = 'weak-password';
const ERROR_EMAIL_ALREADY_IN_USE = 'email-already-in-use';
const ERROR_UID_ALREADY_EXISTS = 'auth/uid-already-exists';
const ERROR_USER_NOT_FOUND = 'user-not-found';
const ERROR_WRONG_PASSWORD = 'wrong-password';

checkError(String error) {
  if (error == ERROR_USER_NOT_FOUND) {
    print('No user found for that email.');
  } else if (error == ERROR_WRONG_PASSWORD) {
    print('Wrong password provided for that user.');
  } else if (error == ERROR_UID_ALREADY_EXISTS) {
    print('The account already exists for that uid.');
  } else if (error == ERROR_EMAIL_ALREADY_IN_USE) {
    print('The account already exists for that email.');
  } else if (error == ERROR_WEAK_PASSWORD) {
    print('The account already exists for that email.');
  }
}
