## Experiment 10: Unit Testing, Widget Testing and Debugging

### Aim
To test Flutter application widgets and verify their behavior using Flutter's testing framework.

### Concepts Used
- `flutter_test` package
- Widget testing with `testWidgets()`
- Assertions using `expect()`
- Widget finding using `find.text()` and `find.byType()`
- Simulating user actions with `tester.tap()`
- Debugging with `flutter analyze` and `flutter test`

### Test Cases
1. Verify that the digital clock screen displays correctly.
2. Verify that the clock format toggles between 12-hour and 24-hour modes.
3. Verify navigation to the World Clock screen.
4. Verify navigation to the Settings screen.

### Result
Static analysis completed without issues, and all four widget tests passed successfully.
### Digital Clock App Output

![Digital Clock App](screenshots/digital_clock.png)
### REST API Output

![World Clock REST API](screenshots/rest_api_world_clock.png)