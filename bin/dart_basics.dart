// ignore_for_file: avoid_print
// ============================================================================
// CS506PC – UI Design (Flutter Lab)
// Experiment 1(b): Simple Dart Program demonstrating Language Basics
// Textbook: Marco L. Napoli, Beginning Flutter: A Hands-on Guide to App Development
// ============================================================================

import 'dart:async';

// 1. Object-Oriented Programming: Class, Properties, Constructor, Methods
class TimeModel {
  final int hour;
  final int minute;
  final int second;
  final String label;

  TimeModel({
    required this.hour,
    required this.minute,
    required this.second,
    this.label = 'STANDARD CLOCK',
  });

  // Getter with string interpolation and zero-padding
  String get formattedTime {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    final s = second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  // 12-hour format converter
  String to12HourFormat() {
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    final period = hour >= 12 ? 'PM' : 'AM';
    final h = displayHour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    final s = second.toString().padLeft(2, '0');
    return '$h:$m:$s $period';
  }
}

// 2. Asynchronous programming function with Future, async, await
Future<String> simulateTimeSync(String timezone) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return 'Synchronized with $timezone at UTC+05:30';
}

void main() async {
  print('====================================================');
  print('CS506PC UI DESIGN LAB - EXPERIMENT 1(b): DART BASICS');
  print('====================================================');

  // Language Basics: Variables, Type Inference & Null Safety
  const String appTitle = 'Digital Clock System';
  final DateTime now = DateTime.now();
  int currentHour = now.hour;
  int currentMinute = now.minute;
  int currentSecond = now.second;

  print('Application Title : $appTitle');
  print('Raw System Time   : $now');

  // Object instantiation
  final clock = TimeModel(
    hour: currentHour,
    minute: currentMinute,
    second: currentSecond,
    label: 'DIGITAL CLOCK LAB',
  );

  print('\n[Time Formatting Test]');
  print('Clock Banner Label : ${clock.label}');
  print('24-Hour Format     : ${clock.formattedTime}');
  print('12-Hour Format     : ${clock.to12HourFormat()}');

  // Collections (List and Map)
  final List<String> supportedTimezones = [
    'Asia/Kolkata',
    'UTC',
    'America/New_York',
    'Europe/London',
    'Asia/Tokyo',
  ];

  final Map<String, String> timezoneOffsets = {
    'Asia/Kolkata': '+05:30',
    'UTC': '+00:00',
    'America/New_York': '-05:00',
    'Europe/London': '+00:00',
    'Asia/Tokyo': '+09:00',
  };

  print('\n[Collections: Supported Timezones]');
  for (var tz in supportedTimezones) {
    print(' • $tz (Offset: ${timezoneOffsets[tz]})');
  }

  // Async Execution
  print('\n[Asynchronous Execution Test]');
  final syncResult = await simulateTimeSync('Asia/Kolkata');
  print('Async Response: $syncResult');

  print('\nExperiment 1(b) Dart Basics Program Executed Successfully!');
  print('====================================================');
}
