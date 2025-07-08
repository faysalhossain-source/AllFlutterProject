import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SeekerService {
  // Base URL for your backend API.
  // IMPORTANT:
  // - For Android emulator, use 'http://10.0.2.2:8081/api' to access localhost on your machine.
  // - For iOS simulator or web, 'http://localhost:8081/api' should work.

  // static const String _baseUrl = 'http://10.0.2.2:8081/api';
  // static const String _baseUrl = 'http://192.168.0.78:8081/api';
  static const  String _baseUrl = 'http://10.0.2.2:8081/api';

  // API Endpoints
  final String _getMyProfileInformationApi = '$_baseUrl/seeker/profile/information';
  final String _editMyProfileInformationApi = '$_baseUrl/seeker/edit/profile/information';
  final String _changeMyPasswordApi = '$_baseUrl/seeker/change-password';
  final String _getAllPostedJobUrlApi = '$_baseUrl/seeker/get/all/posted/job';
  final String _applyJobUrlApi = '$_baseUrl/seeker/apply/job';
  final String _getMyAppliedJobsUrlApi = '$_baseUrl/seeker/my/applied/jobs';
  final String _getShortlistMyAppliedJobUrlApi = '$_baseUrl/seeker/my/shortlisted/applied/job';

  // Helper method to get seekerId from shared_preferences
  Future<String?> _getSeekerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id'); // Assumes 'id' is stored as a String
  }

  // Helper method to handle HTTP responses
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Successful response
      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      }
      return {}; // Return empty map for empty successful responses
    } else {
      // Error response
      String errorBody = response.body.isNotEmpty ? response.body : 'Unknown error';
      throw Exception('Failed to load data: ${response.statusCode} - $errorBody');
    }
  }

  /// Fetches general profile information without a specific ID.
  Future<Map<String, dynamic>> getProfileInformation() async {
    final url = Uri.parse(_getMyProfileInformationApi);
    final response = await http.get(url);
    return _handleResponse(response);
  }

  /// Fetches profile information for a specific seeker ID.
  Future<Map<String, dynamic>> getMyProfileInfo() async {
    final seekerId = await _getSeekerId();
    if (seekerId == null) {
      throw Exception('Seeker ID not found in local storage.');
    }
    // Add query parameter 'id'
    final url = Uri.parse('$_getMyProfileInformationApi?id=$seekerId');
    final response = await http.get(url);
    return _handleResponse(response);
  }

  /// Edits seeker profile information.
  Future<Map<String, dynamic>> editProfileInfo(Map<String, dynamic> data) async {
    final url = Uri.parse(_editMyProfileInformationApi);
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Changes seeker password.
  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) async {
    final url = Uri.parse(_changeMyPasswordApi);
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Fetches all posted jobs.
  Future<List<dynamic>> getAllJobs() async {
    final url = Uri.parse(_getAllPostedJobUrlApi);
    final response = await http.get(url);
    return _handleResponse(response);
  }

  /// Applies for a job.
  Future<Map<String, dynamic>> applyJob(Map<String, dynamic> data) async {
    final url = Uri.parse(_applyJobUrlApi);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Fetches jobs applied by the current seeker.
  Future<List<dynamic>> getMyAppliedJobs(int seekerId) async {
    final seekerId = await _getSeekerId();
    if (seekerId == null) {
      throw Exception('Seeker ID not found in local storage.');
    }
    // Add query parameter 'id'
    final url = Uri.parse('$_getMyAppliedJobsUrlApi?id=$seekerId');
    final response = await http.get(url);
    return _handleResponse(response);
  }


  Future<List<dynamic>> getShortlistMyAppliedJob(int jobs) async {
    final seekerId = await _getSeekerId();
    if (seekerId == null) {
      throw Exception('Seeker ID not found in local storage.');
    }
    // Add query parameter 'seekerId'
    final url = Uri.parse('$_getShortlistMyAppliedJobUrlApi?seekerId=$seekerId');
    final response = await http.get(url);
    return _handleResponse(response);
  }

  /// Login API for seeker
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      return {'message': 'Connection error: ${e.toString()}'};
    }
  }

}
