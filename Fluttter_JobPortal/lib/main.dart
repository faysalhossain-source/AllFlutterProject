import 'package:flutter/material.dart';
import 'package:jobportal/screen/dashboard_screen.dart';
import 'package:jobportal/screen/login_screen.dart';


void main() {
  runApp(const MyJobPortalApp());
}

class MyJobPortalApp extends StatelessWidget {
  const MyJobPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // debug banner for leaving
      title: 'My Job Portal',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
      routes: {

        '/register-company': (context) => const RegisterCompanyScreen(),
        '/register-seeker': (context) => const RegisterSeekerScreen(),
        // if go in dashboard rootly so add this
        '/dashboard': (context) => const JobPortalDashboard(),
      },
    );
  }
}