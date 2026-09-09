import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const DigitalClockApp());
}

class DigitalClockApp extends StatelessWidget {
  const DigitalClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DigitalClockScreen(),
    );
  }
}

class DigitalClockScreen extends StatefulWidget {
  const DigitalClockScreen({super.key});

  @override
  State<DigitalClockScreen> createState() => _DigitalClockScreenState();
}

class _DigitalClockScreenState extends State<DigitalClockScreen> {
  DateTime currentTime = DateTime.now();
  Timer? timer;
  bool is24HourFormat = true;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatNumber(int value) {
    return value.toString().padLeft(2, '0');
  }

  String getMonth(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month - 1];
  }

  String getTime() {
    int hour = currentTime.hour;

    if (is24HourFormat) {
      return '${formatNumber(hour)}:'
          '${formatNumber(currentTime.minute)}:'
          '${formatNumber(currentTime.second)}';
    } else {
      final displayHour = hour % 12 == 0 ? 12 : hour % 12;

      return '${formatNumber(displayHour)}:'
          '${formatNumber(currentTime.minute)}:'
          '${formatNumber(currentTime.second)}';
    }
  }

  String getPeriod() {
    return currentTime.hour >= 12 ? 'PM' : 'AM';
  }

  @override
  Widget build(BuildContext context) {
    final time = getTime();

    final date =
        '${currentTime.day} ${getMonth(currentTime.month)} ${currentTime.year}';

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        is24HourFormat = !is24HourFormat;
                      });
                    },
                    icon: const Icon(Icons.access_time),
                    label: Text(
                      is24HourFormat ? '12 Hour' : '24 Hour',
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white24,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: Colors.cyanAccent,
                          size: 55,
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'DIGITAL CLOCK',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),

                        const SizedBox(height: 30),

                        Text(
                          time,
                          style: const TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),

                        if (!is24HourFormat)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              getPeriod(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        const SizedBox(height: 20),

                        Text(
                          date,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}