
import 'package:flutter/material.dart';


class SeekerProfile extends StatelessWidget {
  const SeekerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seeker Profile'),
      ),
      body: const Center(
        child: Text('This is the Seeker Profile page.'),
      ),
    );
  }
}