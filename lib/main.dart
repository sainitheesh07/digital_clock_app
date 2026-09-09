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

  String formatTime(int value) {
    return value.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    String time =
        '${formatTime(currentTime.hour)}:'
        '${formatTime(currentTime.minute)}:'
        '${formatTime(currentTime.second)}';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          time,
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
          ),
        ),
      ),
    );
  }
}