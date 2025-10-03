import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class ManuPage extends StatelessWidget {
  const ManuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C82F9), // Blue background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Optional spacing

            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 50),
                  const Divider(color: Colors.white38, thickness: 0.5),

                  _buildMenuItem(Icons.home, "Home", AppRoutes.home),
                  _buildMenuItem(Icons.person, "Profile", null),
                  _buildMenuItem(Icons.location_on, "Nearby", null),
                  const Divider(color: Colors.white38, thickness: 0.5),
                  _buildMenuItem(Icons.bookmark, "Bookmark", null),
                  _buildMenuItem(Icons.notifications, "Notification", null),
                  _buildMenuItem(Icons.message, "Message", null),
                  const Divider(color: Colors.white38, thickness: 0.5),
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
        if (route != null) {
          Get.toNamed(route);
        } else if (isLogout) {
          Get.snackbar(
            "Logged out",
            "You have successfully logged out.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black54,
            colorText: Colors.white,
          );
        }
      },
    );
  }
}
