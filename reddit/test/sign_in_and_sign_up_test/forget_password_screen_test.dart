import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit/screens/forget_user_name_and_password/forget_password_screen.dart';

void main() {
  setUp(() {});

  /// in testing we need to tell the app to rebuild the widget tree explicitly.
  testWidgets('Forget your password? text exist', (WidgetTester tester) async {
    /// here we must build the UI first
    await tester.pumpWidget(MaterialApp(
      home: ForgetPasswordScreen(),
    ));

    /// we write what we expect here?
    expect(find.text('Forgot your password?'), findsOneWidget);
  });

  testWidgets('Unfortunately text exists', (WidgetTester tester) async {
    /// here we must build the UI first
    await tester.pumpWidget(MaterialApp(
      home: ForgetPasswordScreen(),
    ));

    /// this rebuilds the widget screen.
    /// here it should wait for 0.5 seconds before rebuilding
    // await tester.pump(const Duration(milliseconds: 500));

    /// we write what we expect here?
    expect(
        find.text(
            'Unfortunately, if you have never given us your email,we will not be able to reset your password.'),
        findsOneWidget);

    /// this method waits till there is no more widget tree building will ever happens
    // await tester.pumpAndSettle();
  });

  testWidgets('there is a Log In button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ForgetPasswordScreen()));
    expect(find.text('Log In'), findsOneWidget);
  });
  testWidgets('there is username textfield', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ForgetPasswordScreen()));
    expect(find.text('Username'), findsOneWidget);
  });
  testWidgets('there is Email textfield', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ForgetPasswordScreen()));
    expect(find.text('Email'), findsOneWidget);
  });
  testWidgets('there is Forget username button exists',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ForgetPasswordScreen()));
    expect(find.text('Forget username?'), findsOneWidget);
  });
  testWidgets('there is Having trouble textfield', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ForgetPasswordScreen()));
    expect(find.text('Having trouble?'), findsOneWidget);
  });
}
