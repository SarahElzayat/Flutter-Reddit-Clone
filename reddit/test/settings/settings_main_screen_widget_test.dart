import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit/screens/settings/settings_main_screen.dart';

void main() {
  setUp(() {});

  /// in testing we need to tell the app to rebuild the widget tree explicitly.
  testWidgets('Account Settings text exist', (WidgetTester tester) async {
    /// here we must build the UI first
    await tester.pumpWidget(const MaterialApp(
      home: SettingsMainScreen(),
    ));

    /// we write what we expect here?
    expect(find.text('Account Settings'), findsOneWidget);
  });

  /// we check whethere we have built the list tile of the sort home posts by or not.
  testWidgets('Sort Home posts by text exist', (WidgetTester tester) async {
    /// here we must build the UI first
    await tester.pumpWidget(const MaterialApp(
      home: SettingsMainScreen(),
    ));

    /// we write what we expect here?
    expect(find.text('Sort Home posts by'), findsOneWidget);
  });

  /// we check whethere we have built the list tile of the auto play by or not.
  testWidgets('AutoPlay text exist', (WidgetTester tester) async {
    /// here we must build the UI first
    await tester.pumpWidget(const MaterialApp(
      home: SettingsMainScreen(),
    ));

    /// we write what we expect here?
    expect(find.text('AutoPlay'), findsOneWidget);
  });

  /// we check whethere we have built the list tile of the NFSW by or not.
  testWidgets('NFSW text exist', (WidgetTester tester) async {
    /// here we must build the UI first
    await tester.pumpWidget(const MaterialApp(
      home: SettingsMainScreen(),
    ));

    /// we write what we e  xpect here?
    expect(find.text('NFSW'), findsOneWidget);
  });
}
