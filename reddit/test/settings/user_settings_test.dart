import 'package:flutter_test/flutter_test.dart';
import 'package:reddit/data/settings/settings_models/user_settings.dart';
import 'package:reddit/data/sign_in_And_sign_up_models/validators.dart';

void main() {
  test("check that username validations shouldn't be less than 3", (() {
    expect(false, Validator.validUserName('ab'));
  }));

  late Map<String, dynamic> data;
  setUp(() {
    data = {
      'email': 'abdelaziz132001@gmail.com',
      'googleEmail': 'zizo@google.com',
      'facebookEmail': 'zizo@facebook.com',
      'country': 'egypt',
      'gender': 'male',
      'displayName': 'Zizo',
      'about': 'zizoGamedAwy',
      'havePassword': 'qweasdzxc',
      'hasVerifiedEmail': true,
      'nsfw': true,
      'allowToFollowYou': true,
      'adultContent': true,
      'autoplayMedia': true,
      'newFollowerEmail': true,
      'unsubscribeFromEmails': true,
    };
  });

  test('user email test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect('abdelaziz132001@gmail.com', model.email);
  });

  test('google email test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.googleEmail, 'zizo@google.com');
  });
  test('Facebook test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.facebookEmail, 'zizo@facebook.com');
  });
  test('country test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.country, 'egypt');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
  test('saved comments profile test', () {
    final UserSettingsModel model = UserSettingsModel.fromJson(data);
    expect(model.email, 'fnsjk');
  });
}
