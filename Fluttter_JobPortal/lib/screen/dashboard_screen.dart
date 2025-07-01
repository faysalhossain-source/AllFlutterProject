import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class JobPortalDashboard extends StatefulWidget {
  const JobPortalDashboard({super.key});

  @override
  State<JobPortalDashboard> createState() => _JobPortalDashboardState();
}

class _JobPortalDashboardState extends State<JobPortalDashboard> {
  final ApiService apiService = ApiService();
  int liveJobs = 0;
  int companies = 0;
  int newJobs = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    try {
      final stats = await apiService.fetchDashboardStats();
      setState(() {
        liveJobs = stats['liveJobs'] ?? 0;
        companies = stats['companies'] ?? 0;
        newJobs = stats['newJobs'] ?? 0;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(count, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.purple,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search Jobs',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.monetization_on, color: Colors.white),
                  const SizedBox(width: 10),
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -10),
                    badgeContent: Text('51', style: TextStyle(color: Colors.white, fontSize: 10)),
                    child: Icon(Icons.notifications, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.email, color: Colors.white),
                  const SizedBox(width: 10),
                  Icon(Icons.more_vert, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem("$liveJobs", "Live Jobs"),
                  _buildStatItem("$companies", "Companies"),
                  _buildStatItem("$newJobs", "New Jobs"),
                ],
              ),
            ),
            // Add more dashboard UI here
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learning'),
          BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'Question'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}
