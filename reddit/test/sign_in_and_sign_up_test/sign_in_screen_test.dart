import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/mobile/sign_in_screen.dart';

void main() {
  setUp(() {});

  testWidgets('there is a log in with google button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));

    // this is how to insert data into certain textfield
    // await tester.enterText(find.byType(TextField), 'Abcdef');

    /// now we are tapping on the continue button
    // await tester.tap(find.byType(ContinueButton));
    expect(find.text('Continue with google'), findsOneWidget);
  });
  testWidgets('there is a log in with facebook button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));
    expect(find.text('Continue with facebook'), findsOneWidget);
  });
  testWidgets('there is a log in with forget password button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));
    expect(find.text('Continue with facebook'), findsOneWidget);
  });

  testWidgets('there is username textfield', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));
    expect(find.text('Username'), findsOneWidget);
  });
  testWidgets('there is password textfield', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));
    expect(find.text('Password'), findsOneWidget);
  });
}
