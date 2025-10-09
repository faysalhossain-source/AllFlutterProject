import 'package:bookss_app/BanlaPoem/banglapoem_screen.dart';
import 'package:bookss_app/EnglishPoem/englishpoem_screen.dart';
import 'package:flutter/material.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  List poems = [BanglapoemScreen(), EnglishpoemScreen()];
  int _CorrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📚 Book App'),
        backgroundColor: Color(0xff05998c),
        elevation: 4,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Text(
            "Welcome to Book App",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Color(0xff964B00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book, size: 100, color: Colors.white),
                  Text(
                    '📚 Book App',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _CorrentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          setState(() {
            _CorrentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Bangla',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'English',
          ),
        ],
      ),
      body: poems[_CorrentIndex],
    );
  }
}
