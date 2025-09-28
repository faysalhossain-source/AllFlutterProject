import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
        centerTitle: true,
        titleSpacing: 10,
        titleTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        toolbarOpacity: 1,
        elevation: 1,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.white,
            hoverColor: Colors.amber.withBlue(1),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
            color: Colors.white,
            hoverColor: Colors.amber.withGreen(1),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
            color: Colors.white,
            hoverColor: Colors.amberAccent.withGreen(1),
          ),
        ],
      ),
    );
  }
}
