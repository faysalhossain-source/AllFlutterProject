import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C82F9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/32.jpg",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Faysal Hossain",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "faysal.hossain@gmail.com",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Menu Items
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(Icons.home, "Home", AppRoutes.home),
                  _buildMenuItem(Icons.person, "Profile", null),
                  _buildMenuItem(Icons.location_on, "Nearby", null),
                  _buildMenuItem(Icons.bookmark, "Bookmark", null),
                  _buildMenuItem(Icons.notifications, "Notification", null),
                  _buildMenuItem(Icons.message, "Message", null),
                  _buildMenuItem(Icons.settings, "Setting", null),
                  _buildMenuItem(Icons.help_outline, "Help", null),
                  const Divider(color: Colors.white38, thickness: 0.5),
                  _buildMenuItem(Icons.logout, "Logout", null, isLogout: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String? route, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isLogout ? Colors.red[200] : Colors.white,
          fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        if (isLogout) {
          Get.snackbar(
            "Logged out",
            "You have successfully logged out.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black54,
            colorText: Colors.white,
          );
        } else if (route != null) {
          Get.toNamed(route);
        }
      },
    );
  }
}
