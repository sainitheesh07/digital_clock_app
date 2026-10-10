import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const DigitalClockApp());
}

class DigitalClockApp extends StatelessWidget {
  const DigitalClockApp({super.key});

  
@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const DigitalClockScreen(),
      '/world-clock': (context) => const WorldClockScreen(),
      '/settings': (context) => const SettingsScreen(),
    },
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
    final screenWidth = MediaQuery.of(context).size.width;

final clockFontSize = screenWidth < 600
    ? 38.0
    : screenWidth < 1024
        ? 55.0
        : 72.0;

final cardPadding = screenWidth < 600 ? 20.0 : 35.0;

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
                  padding: EdgeInsets.all(cardPadding),
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
                    padding: EdgeInsets.all(cardPadding),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.35),
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
                          style: TextStyle(
                            fontSize: clockFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),

                        if (!is24HourFormat)
                          
Padding(
  padding: const EdgeInsets.only(bottom: 20),
  child: Wrap(
    spacing: 12,
    children: [
      ElevatedButton.icon(
        onPressed: () =>
            Navigator.pushNamed(context, '/world-clock'),
        icon: const Icon(Icons.public),
        label: const Text('World Clock'),
      ),
      ElevatedButton.icon(
        onPressed: () =>
            Navigator.pushNamed(context, '/settings'),
        icon: const Icon(Icons.settings),
        label: const Text('Settings'),
      ),
    ],
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

class WorldClockScreen extends StatelessWidget {
  const WorldClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: const Text('World Clock')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.public, size: 60),
            const SizedBox(height: 16),
            Text(
              'Local Time: ${now.hour.toString().padLeft(2, '0')}:'
              '${now.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              child: const Text('Open Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clock Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 60),
            const SizedBox(height: 16),
            const Text(
              'Digital Clock Settings',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
