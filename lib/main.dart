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
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            '00:00:00',
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
        ),
      ),
    );
  }
}