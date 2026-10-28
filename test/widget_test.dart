import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:digital_clock_app/main.dart';
import 'package:digital_clock_app/screens/settings_screen.dart';

void main() {
  testWidgets('Digital clock screen displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DigitalClockApp());

    expect(find.text('DIGITAL CLOCK'), findsOneWidget);
    expect(find.text('12 Hour'), findsOneWidget);
    expect(find.text('World Clock'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('Clock format button toggles correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DigitalClockApp());

    await tester.tap(find.text('12 Hour'));
    await tester.pump();

    expect(find.text('24 Hour'), findsOneWidget);

    await tester.tap(find.text('24 Hour'));
    await tester.pump();

    expect(find.text('12 Hour'), findsOneWidget);
  });

  testWidgets('World Clock navigation works',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DigitalClockApp());

    await tester.tap(find.text('World Clock'));
    await tester.pump();

    expect(find.text('World Clock'), findsOneWidget);
    expect(find.text('Fetching time from REST API...'), findsNothing);
  });

  testWidgets('Settings navigation works',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DigitalClockApp());

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(find.text('Customize Your Clock'), findsOneWidget);
    expect(find.text('Save Settings'), findsOneWidget);
  });

  testWidgets('Settings screen updates clock label and persists via Provider',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DigitalClockApp());

    // Navigate to Settings
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    // Enter a new label in the text form field
    final textFieldFinder = find.byType(TextFormField);
    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, 'OFFICE CLOCK');
    await tester.pump();

    // Tap Save Settings
    await tester.tap(find.text('Save Settings'));
    await tester.pump();

    // Verify current active preview reflects updated label
    expect(find.text('Banner Label: "OFFICE CLOCK"'), findsOneWidget);

    // Pop back to home screen
    tester.state<NavigatorState>(find.byType(Navigator)).pop();
    await tester.pumpAndSettle();

    // Verify home screen now displays the updated label
    expect(find.text('OFFICE CLOCK'), findsOneWidget);
  });
}
