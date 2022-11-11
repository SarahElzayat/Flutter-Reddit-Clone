import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit/Screens/sign_in_and_sign_up_screen/mobile/sign_In_screen.dart';

void main() {
  setUp(() {});

  /// in testing we need to tell the app to rebuild the widget tree explicitly.
  testWidgets('Log in to reddit text exist', (WidgetTester tester) async {
    /// here we must build the UI first
    await tester.pumpWidget(MaterialApp(
      home: SignInScreen(),
    ));

    /// we write what we expect here?
    expect(find.text('Log in to Reddit'), findsOneWidget);
  });

  testWidgets('privacy and policy text exists', (WidgetTester tester) async {
    /// here we must build the UI first
    await tester.pumpWidget(MaterialApp(
      home: SignInScreen(),
    ));

    /// this rebuilds the widget screen.
    /// here it should wait for 0.5 seconds before rebuilding
    // await tester.pump(const Duration(milliseconds: 500));

    /// we write what we expect here?
    expect(
        find.text(
            'By continuing, you agree to our User Agreement and Privace Policy'),
        findsOneWidget);

    /// this method waits till there is no more widget tree building will ever happens
    // await tester.pumpAndSettle();
  });

  testWidgets('there is a log in with google button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    // this is how to insert data into certain textfield
    // await tester.enterText(find.byType(TextField), 'Abcdef');

    /// now we are tapping on the continue button
    // await tester.tap(find.byType(ContinueButton));
    expect(find.text('Continue with google'), findsOneWidget);
  });
  testWidgets('there is a log in with facebook button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));
    expect(find.text('Continue with facebook'), findsOneWidget);
  });
  testWidgets('there is a log in with forget password button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));
    expect(find.text('Continue with facebook'), findsOneWidget);
  });

  testWidgets('there is a sign up button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));
    expect(find.text('Sign Up'), findsOneWidget);
  });
  testWidgets('there is username textfield', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));
    expect(find.text('Username'), findsOneWidget);
  });
  testWidgets('there is password textfield', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));
    expect(find.text('Password'), findsOneWidget);
  });
}
