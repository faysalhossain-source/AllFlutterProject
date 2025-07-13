// lib/services/applied_job_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppliedJobService {
  static const String _baseUrl = 'http://10.0.2.2:8081/api';

  final String _applyJobUrlApi = '$_baseUrl/seeker/apply/job';
  final String _getMyAppliedJobsUrlApi = '$_baseUrl/seeker/my/applied/jobs';

  //  Get seekerId from SharedPreferences
  Future<String?> _getSeekerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  //  Handle API response
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? json.decode(response.body) : {};
    } else {
      throw Exception('Failed: ${response.statusCode} - ${response.body}');
    }
  }

  ///  Apply for a job
  Future<Map<String, dynamic>> applyJob(Map<String, dynamic> data) async {
    final url = Uri.parse(_applyJobUrlApi);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  ///  Get applied jobs for current seeker
  Future<List<dynamic>> getMyAppliedJobs() async {
    final seekerId = await _getSeekerId();
    if (seekerId == null) {
      throw Exception('Seeker ID not found');
    }

    final url = Uri.parse('$_getMyAppliedJobsUrlApi?id=$seekerId');
    final response = await http.get(url);
    return _handleResponse(response);
  }
}
