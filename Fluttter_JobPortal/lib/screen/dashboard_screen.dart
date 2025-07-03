import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../service/api_service.dart'; // Your API service
import 'job_listing_screen.dart'; // Import your JobListingScreen

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

  int _currentIndex = 0; // State to manage the selected tab

  // List of widgets corresponding to each tab in the BottomNavigationBar
  late final List<Widget> _children;

  @override
  void initState() {
    super.initState();
    loadStats();

    // Initialize _children after stats are loaded or directly if not dependent
    _children = [
      // The first tab: Your original dashboard home content
      _DashboardHomeContent(
        liveJobs: liveJobs,
        companies: companies,
        newJobs: newJobs,
        isLoading: isLoading,
        buildStatItem: _buildStatItem, // Pass the helper function
      ),
      // The second tab: Your Job Listing Screen
      const JobListingScreen(),
      // The third tab: Placeholder for 'More' content
      const Center(child: Text('More Content', style: TextStyle(fontSize: 24, color: Colors.black54))),
    ];
  }

  @override
  void didUpdateWidget(covariant JobPortalDashboard oldWidget) {
    super.didUpdateWidget(oldWidget);

    (_children[0] as _DashboardHomeContent).updateStats(liveJobs, companies, newJobs, isLoading);
  }


  Future<void> loadStats() async {
    try {
      final stats = await apiService.fetchDashboardStats();
      setState(() {
        liveJobs = stats['liveJobs'] ?? 0;
        companies = stats['companies'] ?? 0;
        newJobs = stats['newJobs'] ?? 0;
        isLoading = false;
        // Update the _DashboardHomeContent with the new stats
        (_children[0] as _DashboardHomeContent).updateStats(liveJobs, companies, newJobs, isLoading);
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
        (_children[0] as _DashboardHomeContent).updateStats(liveJobs, companies, newJobs, isLoading);
      });
    }
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(count, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  // Function to handle tab taps
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
                  const CircleAvatar(
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
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.monetization_on, color: Colors.white),
                  const SizedBox(width: 10),
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -10),
                    badgeContent: const Text('51', style: TextStyle(color: Colors.white, fontSize: 10)),
                    child: const Icon(Icons.notifications, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.email, color: Colors.white),
                  const SizedBox(width: 10),
                  const Icon(Icons.more_vert, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people_alt), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Jobs'), // This tab will show JobListingScreen
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

class _DashboardHomeContent extends StatefulWidget {
  final int liveJobs;
  final int companies;
  final int newJobs;
  final bool isLoading;
  final Widget Function(String, String) buildStatItem;

  const _DashboardHomeContent({
    Key? key,
    required this.liveJobs,
    required this.companies,
    required this.newJobs,
    required this.isLoading,
    required this.buildStatItem,
  }) : super(key: key);

  @override
  State<_DashboardHomeContent> createState() => _DashboardHomeContentState();


  void updateStats(int live, int comp, int newJ, bool loading) {

    if (_DashboardHomeContentState._instance != null && _DashboardHomeContentState._instance!.mounted) {
      _DashboardHomeContentState._instance!.updateInternalStats(live, comp, newJ, loading);
    }
  }
}

class _DashboardHomeContentState extends State<_DashboardHomeContent> {
  static _DashboardHomeContentState? _instance;

  late int _liveJobs;
  late int _companies;
  late int _newJobs;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _instance = this;
    _liveJobs = widget.liveJobs;
    _companies = widget.companies;
    _newJobs = widget.newJobs;
    _isLoading = widget.isLoading;
  }

  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }

  void updateInternalStats(int live, int comp, int newJ, bool loading) {
    if (mounted) {
      setState(() {
        _liveJobs = live;
        _companies = comp;
        _newJobs = newJ;
        _isLoading = loading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.purple,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                widget.buildStatItem("$_liveJobs", "Live Jobs"),
                widget.buildStatItem("$_companies", "Companies"),
                widget.buildStatItem("$_newJobs", "New Jobs"),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome to you in Job Portal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          Container(
            height: 200,
            color: Colors.grey[200],
            margin: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const Text('Recent Activities / Featured Jobs Placeholder'),
          ),
          // ... more dashboard widgets
        ],
      ),
    );
  }
}