import 'package:Dictionary/authentication/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Email should be validated", () {
    expect(Validators.isValidEmail("aaa"), false);
    expect(Validators.isValidEmail("aaa@aaa."), false);
    expect(Validators.isValidEmail("aaa@aaa"), false);
    expect(Validators.isValidEmail("aaa@aaa..com"), false);
    expect(Validators.isValidEmail("aa a@aaa..com"), false);

    expect(Validators.isValidEmail("aaa@aaa.com"), true);
  });

  test("Password should be validated", () {
    expect(Validators.isValidPassword("1"), false);
    expect(Validators.isValidPassword(" "), false);
    expect(Validators.isValidPassword("1234567"), false);
    expect(Validators.isValidPassword("12345678"), false);
    expect(Validators.isValidPassword("******"), false);
    expect(Validators.isValidPassword("............."), false);
    expect(Validators.isValidPassword("--------------"), false);
    expect(Validators.isValidPassword("--------------"), false);
    expect(Validators.isValidPassword("       "), false);
    expect(Validators.isValidPassword("qwertyyy"), false);
    expect(Validators.isValidPassword("ThisIsAValidPassword"), false);

    expect(Validators.isValidPassword("Qwerty123"), true);
    expect(Validators.isValidPassword("qwerty123"), true);
  });
}
