import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';



class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});



  @override

  State<LoginScreen> createState() => _LoginScreenState();

}



class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();



  bool isLoading = false;



  Future<void> loginUser() async {

    setState(() {

      isLoading = true;

    });



    final email = emailController.text.trim();

    final password = passwordController.text;



    if (email.isEmpty || password.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text('Please enter email and password')),

      );

      setState(() {

        isLoading = false;

      });

      return;

    }



    try {

      final response = await http.post(

        Uri.parse('http://10.0.2.2:8081/api/auth/login'),

        headers: {'Content-Type': 'application/json'},

        body: jsonEncode({'email': email, 'password': password}),

      );



      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);



        final token = data['token']; // Adjust key according to your backend response

        if (token != null) {

          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('jwt_token', token);



          ScaffoldMessenger.of(context).showSnackBar(

            SnackBar(content: Text('Login successful!')),

          );



// Navigate to home page or main app screen

          Navigator.pushReplacementNamed(context, '/home');

        } else {

          ScaffoldMessenger.of(context).showSnackBar(

            SnackBar(content: Text('Invalid token received')),

          );

        }

      } else {

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(content: Text('Login failed: ${response.statusCode}')),

        );

      }

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text('Error occurred: $e')),

      );

    } finally {

      setState(() {

        isLoading = false;

      });

    }

  }



  @override

  void dispose() {

    emailController.dispose();

    passwordController.dispose();

    super.dispose();

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('Login')),

      body: Padding(

        padding: EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller: emailController,

              keyboardType: TextInputType.emailAddress,

              decoration: InputDecoration(labelText: 'Email'),

            ),

            SizedBox(height: 12),

            TextField(

              controller: passwordController,

              obscureText: true,

              decoration: InputDecoration(labelText: 'Password'),

            ),

            SizedBox(height: 24),

            isLoading

                ? CircularProgressIndicator()

                : ElevatedButton(

              onPressed: loginUser,

              child: Text('Login'),

            ),

          ],

        ),

      ),

    );

  }

}