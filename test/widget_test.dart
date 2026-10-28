/// ============================================================================
/// CS506PC – UI Design (Flutter Lab)
/// Experiment 10: a) Unit & Widget Testing | b) Debugging & Static Analysis
/// Textbook: Marco L. Napoli, Beginning Flutter: A Hands-on Guide to App Development
/// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:digital_clock_app/main.dart';
import 'package:digital_clock_app/screens/settings_screen.dart';

void main() {
  group('CS506PC Experiment 10: Digital Clock Widget Test Suite', () {
    // Test Case 1: Core widget tree & layout verification (Exp 2 & 10)
    testWidgets('1. Digital clock screen displays correctly with core widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DigitalClockApp());

      expect(find.text('DIGITAL CLOCK'), findsOneWidget);
      expect(find.text('12 Hour'), findsOneWidget);
      expect(find.text('World Clock'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    // Test Case 2: State toggle verification (Exp 5 & 10)
    testWidgets('2. Clock format button toggles between 12-hour and 24-hour mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DigitalClockApp());

      await tester.tap(find.text('12 Hour'));
      await tester.pump();

      expect(find.text('24 Hour'), findsOneWidget);

      await tester.tap(find.text('24 Hour'));
      await tester.pump();

      expect(find.text('12 Hour'), findsOneWidget);
    });

    // Test Case 3: Navigator pushNamed verification for World Clock (Exp 4 & 10)
    testWidgets('3. World Clock navigation works via Navigator named route',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DigitalClockApp());

      await tester.tap(find.text('World Clock'));
      await tester.pump();

      expect(find.text('World Clock'), findsOneWidget);
      expect(find.text('Fetching time from REST API...'), findsNothing);
    });

    // Test Case 4: Navigator pushNamed verification for Settings Screen (Exp 4 & 10)
    testWidgets('4. Settings navigation works and renders Form widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DigitalClockApp());

      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(find.text('Customize Your Clock'), findsOneWidget);
      expect(find.text('Save Settings'), findsOneWidget);
    });

    // Test Case 5: Provider state persistence and two-way sync (Exp 5, 7 & 10)
    testWidgets('5. Settings form updates clock banner label and persists via Provider',
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
  });
}
