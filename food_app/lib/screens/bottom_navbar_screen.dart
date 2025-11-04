import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_app/consts/all_colors.dart';
import 'package:food_app/widgets/favourite_screen.dart';
import 'package:food_app/widgets/home_screen.dart';
import 'package:food_app/widgets/message_screen.dart';
import 'package:food_app/widgets/profile_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  List<IconData> icons = [
    Icons.home,
    Icons.person,
    Icons.message,
    Icons.favorite,
  ];
  List<Widget> page = [
    HomeScreen(),
    ProfileScreen(),
    MessageScreen(),
    FavouriteScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AllColors.primaryColors,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AllColors.whiteColors),
        onPressed: () {},
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: AllColors.primaryColors,
        notchSmoothness: NotchSmoothness.smoothEdge,
        gapLocation: GapLocation.center,
        inactiveColor: AllColors.lightGrayColors.withValues(alpha: 0.8),
        activeColor: AllColors.whiteColors,
        icons: icons,
        activeIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      body: page[currentIndex],
    );
  }
}
