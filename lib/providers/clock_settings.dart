
import 'package:flutter/material.dart';

class ClockSettings extends ChangeNotifier {
  bool _is24HourFormat = true;

  bool get is24HourFormat => _is24HourFormat;

  void toggleTimeFormat() {
    _is24HourFormat = !_is24HourFormat;
    notifyListeners();
  }

  void setTimeFormat(bool use24HourFormat) {
    if (_is24HourFormat == use24HourFormat) return;

    _is24HourFormat = use24HourFormat;
    notifyListeners();
  }
}
