import 'package:flutter/material.dart';

/// Provider for managing global clock settings and application preferences.
/// (Experiment 7: State Management using Provider)
class ClockSettings extends ChangeNotifier {
  bool _is24HourFormat = true;
  String _clockLabel = 'DIGITAL CLOCK';

  bool get is24HourFormat => _is24HourFormat;
  String get clockLabel => _clockLabel;

  /// Toggles between 12-hour and 24-hour time format.
  void toggleTimeFormat() {
    _is24HourFormat = !_is24HourFormat;
    notifyListeners();
  }

  /// Sets the 12-hour or 24-hour time format explicitly.
  void setTimeFormat(bool use24HourFormat) {
    if (_is24HourFormat == use24HourFormat) return;

    _is24HourFormat = use24HourFormat;
    notifyListeners();
  }

  /// Updates the custom label displayed on the clock banner.
  void setClockLabel(String newLabel) {
    final trimmed = newLabel.trim();
    if (trimmed.isEmpty || _clockLabel == trimmed) return;

    _clockLabel = trimmed;
    notifyListeners();
  }

  /// Resets settings to factory defaults.
  void resetDefaults() {
    _is24HourFormat = true;
    _clockLabel = 'DIGITAL CLOCK';
    notifyListeners();
  }
}
