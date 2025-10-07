import 'package:book_app/bangla_screen.dart';
import 'package:book_app/english_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {

  List pages=[BanglaScreen(),EnglishScreen()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book App'),
      ),
      drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book_rounded,size: 100,color: Colors.white),
                    Text('Poem Book',style: TextStyle(color: Colors.white,fontSize: 16),)
                  ],
                )
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home',style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Setting',style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Aboud',style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          setState(() {
            _currentIndex=value;
            //print(_currentIndex);
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book),label: "Bangla"),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined),label: "English"),
        ],
        ),
        body: pages[_currentIndex],
    );
  }
}