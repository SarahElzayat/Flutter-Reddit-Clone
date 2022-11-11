import 'package:flutter_test/flutter_test.dart';
import 'package:reddit/data/sign_in_And_sign_up_models/validators.dart';

void main() {
  /// sut -> system under test
  /// setUP method => it is a method that runs before each and every test.

  test("check that username validations shouldn't be less than 3", (() {
    expect(false, Validator.validUserName('ab'));
  }));

  test("check that username validations shouldn't be greater than 20", (() {
    expect(false, Validator.validUserName('abcdefghijklmnopqrstu'));
  }));

  test('check that any username if the username was exactly 20 it will pass',
      (() {
    expect(true, Validator.validUserName('abcdefghijklmnopqrst')); // 20 chars
  }));
  test('check that any username if the username was exactly 3 it will pass',
      (() {
    expect(true, Validator.validUserName('abc')); // 3 chars
  }));
  test(
      'check that any username if the username was between 3 and 20 it will pass also',
      (() {
    expect(true, Validator.validUserName('abcdefghij')); // 10 chars
  }));
  test('check that username should not be empty', (() {
    expect(false, Validator.validUserName('')); // 10 chars
  }));

  /// password tests
  test('check that password should not be less than 8', (() {
    expect(false, Validator.validPasswordValidation('12345')); // 10 chars
  }));
  test('check that password should not be less than 8', (() {
    expect(false, Validator.validPasswordValidation('1234567')); // 10 chars
  }));
  test('check that password should not be empty', (() {
    expect(false, Validator.validPasswordValidation('')); // 10 chars
  }));
  test('check that password can be greater than 7', (() {
    expect(true, Validator.validPasswordValidation('123456789')); // 10 chars
  }));

  /// validating emails
  test('check that email must follow this formate anything@example.com', (() {
    expect(true, Validator.validEmailValidator('abdelaziz132001@gmail.com'));
  }));

  test(
      'check that if there is double @ it will give false as in this formate anything@@example.com',
      (() {
    expect(false, Validator.validEmailValidator('abdelaziz132001@@gmail.com'));
  }));
  test(
      'check that if there is double . it will return false formate anything@example..com',
      (() {
    expect(false, Validator.validEmailValidator('abdelaziz132001@gmail..com'));
  }));
  test('check that email can not be left empty', (() {
    expect(false, Validator.validEmailValidator(''));
  }));
  test('check that email can not be left empty', (() {
    expect(false, Validator.validEmailValidator(''));
  }));
}
