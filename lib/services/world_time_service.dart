import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service for fetching world time data from a public REST API.
/// (Experiment 9: REST API Integration & Asynchronous Programming)
class WorldTimeService {
  static const String primaryUrl =
      'https://worldtimeapi.org/api/timezone/Asia/Kolkata';
  static const String backupUrl =
      'https://worldtime.timezone.io/api/timezone/Asia/Kolkata';

  /// Fetches real-time timezone and timestamp data from REST API.
  Future<Map<String, dynamic>> fetchWorldTime() async {
    // Attempt primary REST API
    try {
      final response = await http
          .get(Uri.parse(primaryUrl))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {
      // Primary failed; continue to secondary endpoint
    }

    // Attempt backup REST API
    try {
      final response = await http
          .get(Uri.parse(backupUrl))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {
      // Fall through to simulated fallback when network is unavailable
    }

    // If completely offline, return standard formatted local time payload
    final now = DateTime.now();
    return {
      'timezone': 'Asia/Kolkata (Local Sync)',
      'datetime': now.toIso8601String(),
      'utc_offset': '+05:30',
      'day_of_week': now.weekday,
      'day_of_year': int.parse(
        "${now.difference(DateTime(now.year, 1, 1)).inDays + 1}",
      ),
      'is_fallback': true,
    };
  }
}
