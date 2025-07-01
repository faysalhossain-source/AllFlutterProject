import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http:// 172.25.80.1:8081/api/dashboard"; // YOUR_IP দিন

  Future<Map<String, dynamic>> fetchDashboardStats() async {
    final response = await http.get(Uri.parse("$baseUrl/stats"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load dashboard stats');
    }
  }
}
