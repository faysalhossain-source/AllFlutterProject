import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loginUser(String email, String password, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8081/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('📡 Status Code: ${response.statusCode}');
    print('📦 Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token']; // Make sure this matches your backend response field

      // Save token in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      // Optionally save userId, name, etc. if needed
      // await prefs.setInt('user_id', data['id']);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Login successful')),
      );

      // Navigate to home page or wherever you want
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Login failed. Please try again.')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('⚠️ Error: $e')),
    );
  }
}
