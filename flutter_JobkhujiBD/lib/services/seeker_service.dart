// seeker_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SeekerService {
  static const String _baseUrl = 'http://10.0.2.2:8081/api';

  final String _getMyProfileInformationApi = '$_baseUrl/seeker/profile/information';
  final String _editMyProfileInformationApi = '$_baseUrl/seeker/edit/profile/information';
  final String _changeMyPasswordApi = '$_baseUrl/seeker/change-password';
  final String _getAllPostedJobUrlApi = '$_baseUrl/seeker/get/all/posted/job';

  Future<String?> _getSeekerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      }
      return {};
    } else {
      String errorBody = response.body.isNotEmpty ? response.body : 'Unknown error';
      throw Exception('Failed to load data: ${response.statusCode} - $errorBody');
    }
  }

  Future<Map<String, dynamic>> getProfileInformation() async {
    final url = Uri.parse(_getMyProfileInformationApi);
    final response = await http.get(url);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> getMyProfileInfo() async {
    final seekerId = await _getSeekerId();
    if (seekerId == null) {
      throw Exception('Seeker ID not found in local storage.');
    }
    final url = Uri.parse('$_getMyProfileInformationApi?id=$seekerId');
    final response = await http.get(url);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> editProfileInfo(Map<String, dynamic> data) async {
    final url = Uri.parse(_editMyProfileInformationApi);
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) async {
    final url = Uri.parse(_changeMyPasswordApi);
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  Future<List<dynamic>> getAllJobs() async {
    final url = Uri.parse(_getAllPostedJobUrlApi);
    final response = await http.get(url);
    return _handleResponse(response);
  }

  Future<List<dynamic>> getShortlistMyAppliedJob() async {
    throw UnimplementedError('getShortlistMyAppliedJob is not implemented because its URL was removed.');
  }

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
