import 'package:flutter/material.dart';
import 'package:jobportal/screen/dashboard_screen.dart';


void main() {
  runApp(const MyJobPortalApp());
}

class MyJobPortalApp extends StatelessWidget {
  const MyJobPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Job Portal',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const JobPortalDashboard(),
    );
  }
}
