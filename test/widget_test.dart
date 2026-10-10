
import 'package:flutter_test/flutter_test.dart';
import 'package:digital_clock_app/main.dart';

void main() {
  testWidgets('Digital clock screen displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DigitalClockApp());

    expect(find.text('DIGITAL CLOCK'), findsOneWidget);
    expect(find.text('12 Hour'), findsOneWidget);
  });

  testWidgets('Clock format button toggles correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DigitalClockApp());

    await tester.tap(find.text('12 Hour'));
    await tester.pump();

    expect(find.text('24 Hour'), findsOneWidget);
  });
}
