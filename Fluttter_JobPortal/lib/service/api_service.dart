import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/job.dart';
import '../model/seeker_profile.dart';
import '../screen/seeker_profile.dart' hide SeekerProfile;



class ApiService {
  // final String _baseUrl = 'http://10.0.2.2:8081';
  final String _baseUrl = 'http://192.168.0.78:8081';

  Future<int?> _getSeekerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  Future<Map<String, dynamic>> getProfileInformation() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/seeker/profile/information'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile information: ${response.statusCode}');
    }
  }

  Future<SeekerProfile> getMyProfileInfo() async {
    final seekerId = await _getSeekerId();
    if (seekerId == null) {
      throw Exception('Seeker ID not found in local storage.');
    }
    final uri = Uri.parse('$_baseUrl/api/seeker/profile/information')
        .replace(queryParameters: {'id': seekerId.toString()});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return SeekerProfile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load my profile information: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> editProfileInfo(Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/api/seeker/edit/profile/information'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to edit profile information: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> changePassword({required int id, required String currentPassword, required String newPassword}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/api/seeker/change-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': id,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to change password: ${response.statusCode}');
    }
  }

  Future<List<Job>> getAllJobs() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/seeker/get/all/posted/job'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Job.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load all posted jobs: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> applyJob(Map<String, int> data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/seeker/apply/job'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to apply for job: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<Job>> getMyAppliedJobs() async {
    final seekerId = await _getSeekerId();
    if (seekerId == null) {
      throw Exception('Seeker ID not found in local storage.');
    }
    final uri = Uri.parse('$_baseUrl/api/seeker/my/applied/jobs')
        .replace(queryParameters: {'id': seekerId.toString()});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Job.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load my applied jobs: ${response.statusCode}');
    }
  }

  Future<List<Job>> getShortlistMyAppliedJob() async {
    final seekerId = await _getSeekerId();
    if (seekerId == null) {
      throw Exception('Seeker ID not found in local storage.');
    }
    final uri = Uri.parse('$_baseUrl/api/seeker/my/shortlisted/applied/job')
        .replace(queryParameters: {'seekerId': seekerId.toString()});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Job.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load shortlisted applied jobs: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchDashboardStats() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/dashboard/stats'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load dashboard stats: ${response.statusCode}');
    }
  }
}



