
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
    expect(find.text('Fetching time from REST API...'), findsOneWidget);
  });

  testWidgets('Settings navigation works',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DigitalClockApp());

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
  });
}
