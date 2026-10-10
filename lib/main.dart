
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/world_time_service.dart';
import 'providers/clock_settings.dart';
import 'widgets/clock_action_button.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const DigitalClockApp());
}

class DigitalClockApp extends StatelessWidget {
  const DigitalClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClockSettings(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0F2027),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.cyanAccent,
            brightness: Brightness.dark,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF203A43),
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const DigitalClockScreen(),
          '/world-clock': (context) => const WorldClockScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}

class DigitalClockScreen extends StatefulWidget {
  const DigitalClockScreen({super.key});

  @override
  State<DigitalClockScreen> createState() =>
      _DigitalClockScreenState();
}

class _DigitalClockScreenState extends State<DigitalClockScreen>
    with SingleTickerProviderStateMixin {
  DateTime currentTime = DateTime.now();
  Timer? timer;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Experiment 8: Fade-in animation.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    // Update the digital clock every second.
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        setState(() {
          currentTime = DateTime.now();
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _animationController.dispose();
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
    final settings = context.read<ClockSettings>();
    final hour = currentTime.hour;

    if (settings.is24HourFormat) {
      return '${formatNumber(hour)}:'
          '${formatNumber(currentTime.minute)}:'
          '${formatNumber(currentTime.second)}';
    }

    final displayHour = hour % 12 == 0 ? 12 : hour % 12;

    return '${formatNumber(displayHour)}:'
        '${formatNumber(currentTime.minute)}:'
        '${formatNumber(currentTime.second)}';
  }

  String getPeriod() {
    return currentTime.hour >= 12 ? 'PM' : 'AM';
  }

  @override
  Widget build(BuildContext context) {
    final clockSettings = context.watch<ClockSettings>();
    final screenWidth = MediaQuery.of(context).size.width;

    // Experiment 3: Responsive breakpoints.
    final clockFontSize = screenWidth < 600
        ? 38.0
        : screenWidth < 1024
            ? 55.0
            : 72.0;

    final cardPadding = screenWidth < 600 ? 20.0 : 35.0;

    final time = getTime();

    final date =
        '${currentTime.day} ${getMonth(currentTime.month)} '
        '${currentTime.year}';

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
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context
                          .read<ClockSettings>()
                          .toggleTimeFormat();
                    },
                    icon: const Icon(Icons.access_time),
                    label: Text(
                      clockSettings.is24HourFormat
                          ? '12 Hour'
                          : '24 Hour',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 750,
                      ),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(8),
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
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(height: 25),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    fontSize: clockFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                              ),
                              if (!clockSettings.is24HourFormat)
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
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 28),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  ClockActionButton(
                                    icon: Icons.public,
                                    label: 'World Clock',
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/world-clock',
                                      );
                                    },
                                  ),
                                  ClockActionButton(
                                    icon: Icons.settings,
                                    label: 'Settings',
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/settings',
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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


class WorldClockScreen extends StatefulWidget {
  const WorldClockScreen({super.key});

  @override
  State<WorldClockScreen> createState() => _WorldClockScreenState();
}

class _WorldClockScreenState extends State<WorldClockScreen> {
  final WorldTimeService _worldTimeService = WorldTimeService();

  late Future<Map<String, dynamic>> _timeFuture;

  @override
  void initState() {
    super.initState();
    _timeFuture = _worldTimeService.fetchWorldTime();
  }

  void _retryFetch() {
    setState(() {
      _timeFuture = _worldTimeService.fetchWorldTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Clock'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder<Map<String, dynamic>>(
            future: _timeFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Fetching time from REST API...'),
                  ],
                );
              }

              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_off,
                      size: 60,
                      color: Colors.orangeAccent,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Unable to fetch time.',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _retryFetch,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                );
              }

              final data = snapshot.data!;
              final dateTimeText =
                  data['datetime']?.toString() ?? 'Unavailable';
              final timezone =
                  data['timezone']?.toString() ?? 'Asia/Kolkata';
              final utcOffset =
                  data['utc_offset']?.toString() ?? 'Unavailable';

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.public,
                    size: 60,
                    color: Colors.cyanAccent,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Time from REST API',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    timezone,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    dateTimeText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('UTC offset: $utcOffset'),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _retryFetch,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh Time'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Clock'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
