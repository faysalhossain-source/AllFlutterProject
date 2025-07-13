import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/job_model.dart';

class JobHomePage extends StatefulWidget {
  const JobHomePage({super.key});

  @override
  _JobHomePageState createState() => _JobHomePageState();
}

class _JobHomePageState extends State<JobHomePage> {
  final ScrollController _scrollController = ScrollController();
  List<Job> jobs = [];
  String searchQuery = '';
  int _selectedIndex = 0;
  bool isLoading = true;

  // ✅ Profile Info
  String? name, email, imageUrl;

  @override
  void initState() {
    super.initState();
    fetchJobs();
    loadProfileInfo(); // Load name, email, image
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchJobs() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8081/api/seeker/get/all/posted/job'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          jobs = jsonData.map((json) => Job.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadProfileInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');
      imageUrl = prefs.getString('imageUrl'); // Optional
    });
  }

  void _onBottomNavTap(int index) {
    setState(() => _selectedIndex = index);
    if (index == 1) Navigator.pushNamed(context, '/applied');
    if (index == 2) Navigator.pushNamed(context, '/job list');
  }

  @override
  Widget build(BuildContext context) {
    final filteredJobs = jobs.where((job) =>
        job.jobTitle.toLowerCase().contains(searchQuery.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          backgroundColor: Colors.purple,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                      ? NetworkImage(imageUrl!)
                      : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name ?? 'Guest',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(email ?? '',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.wallet, color: Colors.white),
                const SizedBox(width: 10),
                const Icon(Icons.notifications_none, color: Colors.white),
                const SizedBox(width: 10),
                const Icon(Icons.mail_outline, color: Colors.white),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search Jobs',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : filteredJobs.isEmpty
          ? const Center(child: Text('No jobs found'))
          : LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Text(
                        "Find Your Dream Job Today!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("Recommended Jobs",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple)),
                    ),
                    const SizedBox(height: 10),
                    ...filteredJobs.map((job) => _jobCard(job)).toList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'My Applied job'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Job List'),
        ],
      ),
    );
  }

  Widget _jobCard(Job job) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.jobTitle,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.business, size: 20, color: Colors.grey),
                const SizedBox(width: 6),
                Text(job.company.name, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: [
                Chip(
                  label: Text(job.employmentStatus, style: const TextStyle(color: Colors.white)),
                  backgroundColor: Colors.green,
                ),
                Chip(
                  label: Text(job.workPlace),
                  backgroundColor: Colors.blue.shade100,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red, size: 20),
                const SizedBox(width: 6),
                Text(job.jobLocation),
              ],
            ),
            const SizedBox(height: 12),
            Text("📝 Description", style: _sectionTitleStyle()),
            Text(job.jobDescription, style: _bodyTextStyle()),
            const SizedBox(height: 10),
            Text("📌 Requirement", style: _sectionTitleStyle()),
            Text(job.jobRequirement, style: _bodyTextStyle()),
            const SizedBox(height: 10),
            Text("💼 Responsibilities", style: _sectionTitleStyle()),
            Text(job.jobResponsibilities, style: _bodyTextStyle()),
            const SizedBox(height: 10),
            Text("💰 Compensation & Benefits", style: _sectionTitleStyle()),
            Text(job.compensationBenefit, style: _bodyTextStyle()),
            const SizedBox(height: 10),
            Text("📅 Posted On: ${job.createdAt.toLocal().toString().split(' ')[0]}",
                style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? token = prefs.getString('jwt_token');
                  String? seekerId = prefs.getString('id');

                  if (token == null || seekerId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('You are not logged in.')),
                    );
                    return;
                  }

                  try {
                    final response = await http.post(
                      Uri.parse('http://10.0.2.2:8081/api/seeker/apply/job'),
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer $token',
                      },
                      body: jsonEncode({
                        'jobId': job.id,
                        'seekerId': int.parse(seekerId),
                      }),
                    );

                    if (response.statusCode == 200 || response.statusCode == 201) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Application submitted successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${response.body}')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error occurred: $e')),
                    );
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text('Apply Now'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _sectionTitleStyle() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple);
  }

  TextStyle _bodyTextStyle() {
    return const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4);
  }
}
