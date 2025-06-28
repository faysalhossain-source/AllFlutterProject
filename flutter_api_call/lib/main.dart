import 'package:flutter/material.dart';
import 'package:flutter_api_call/screen/online_employee_screeen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Crud',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnlineEmployeeScreen()
    );
  }
}