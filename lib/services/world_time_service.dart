
import 'dart:convert';
import 'package:http/http.dart' as http;

class WorldTimeService {
  static const String apiUrl =
      'https://worldtime.timezone.io/api/timezone/Asia/Kolkata';

  Future<Map<String, dynamic>> fetchWorldTime() async {
    final response = await http
        .get(Uri.parse(apiUrl))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception(
      'Failed to load time. Status code: ${response.statusCode}',
    );
  }
}
