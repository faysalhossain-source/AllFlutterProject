import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jobkhujibd/screens/LoginScreen.dart';
import 'package:flutter_jobkhujibd/screens/jobseeker_screen/JobHomePage.dart';
import 'package:flutter_jobkhujibd/screens/jobseeker_screen/SeekerApplyScreen.dart';
import 'package:flutter_jobkhujibd/screens/seeker_shortlist_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobKhujibd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => JobHomePage(),
        '/applied': (context) => SeekerApplyScreen(),
        '/shortlist': (context) => SeekerShortlistScreen(),
        '/login': (context) => const LoginPage(),
        ///'/register-company': (context) => const RegisterCompanyPage(),
        ///'/register-seeker': (context) => const RegisterSeekerPage(),
      },
    );
  }
}
