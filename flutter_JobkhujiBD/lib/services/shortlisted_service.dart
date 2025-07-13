// lib/services/shortlisted_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShortlistedService {
  static const String _baseUrl = 'http://10.0.2.2:8081/api';
  final String _getShortlistedJobsUrl = '$_baseUrl/seeker/my/shortlisted/applied/job';

  Future<String?> _getSeekerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? json.decode(response.body) : {};
    } else {
      throw Exception('Failed: ${response.statusCode} - ${response.body}');
    }
  }

  /// Get shortlisted jobs for current seeker
  Future<List<dynamic>> getShortlistedJobs() async {
    final seekerId = await _getSeekerId();
    if (seekerId == null) throw Exception('Seeker ID not found');

    final url = Uri.parse('$_getShortlistedJobsUrl?seekerId=$seekerId');
    final response = await http.get(url);
    return _handleResponse(response);
  }
}
