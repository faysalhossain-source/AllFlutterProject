import 'package:flutter/material.dart';
import 'package:flutter_jobkhujibd/screens/LoginScreen.dart';
import 'package:flutter_jobkhujibd/screens/jobseeker_screen/JobHomePage.dart';
import 'package:flutter_jobkhujibd/screens/jobseeker_screen/SeekerAppliedJobScreen.dart';
import 'package:flutter_jobkhujibd/screens/seeker_shortlist_screen.dart';
// import 'package:flutter_jobkhujibd/screens/register/RegisterCompanyPage.dart';
// import 'package:flutter_jobkhujibd/screens/register/RegisterSeekerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/': (context) => const JobHomePage(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const JobHomePage(),
        '/applied': (context) => const SeekerAppliedJobScreen(),
        '/shortlist': (context) => const SeekerShortlistScreen(),
        // '/register-company': (context) => const RegisterCompanyPage(),
        // '/register-seeker': (context) => const RegisterSeekerPage(),
      },
    );
  }
}
