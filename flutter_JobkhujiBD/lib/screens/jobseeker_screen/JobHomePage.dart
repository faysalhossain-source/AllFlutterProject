import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // avoid memory leak
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
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        toolbarHeight: 100,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Row(
            children: [
              CircleAvatar(radius: 24),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search Jobs',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.wallet, color: Colors.white),
              SizedBox(width: 10),
              Icon(Icons.notifications_none, color: Colors.white),
              SizedBox(width: 10),
              Icon(Icons.mail_outline, color: Colors.white),
            ],
          ),
        ),
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : filteredJobs.isEmpty
          ? Center(child: Text('No jobs found'))
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Text(
                        "Find Your Dream Job Today!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text("Recommended Jobs",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple)),
                    ),
                    SizedBox(height: 10),

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

  /// Job Card Design
  Widget _jobCard(Job job) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.jobTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.business, size: 20, color: Colors.grey[700]),
                SizedBox(width: 6),
                Text(job.company.name, style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: [
                Chip(
                  label: Text(job.employmentStatus, style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.green,
                ),
                Chip(
                  label: Text(job.workPlace),
                  backgroundColor: Colors.blue.shade100,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 20),
                SizedBox(width: 6),
                Text(job.jobLocation),
              ],
            ),
            SizedBox(height: 12),
            Text("📝 Description", style: _sectionTitleStyle()),
            Text(job.jobDescription, style: _bodyTextStyle()),
            SizedBox(height: 10),
            Text("📌 Requirement", style: _sectionTitleStyle()),
            Text(job.jobRequirement, style: _bodyTextStyle()),
            SizedBox(height: 10),
            Text("💼 Responsibilities", style: _sectionTitleStyle()),
            Text(job.jobResponsibilities, style: _bodyTextStyle()),
            SizedBox(height: 10),
            Text("💰 Compensation & Benefits", style: _sectionTitleStyle()),
            Text(job.compensationBenefit, style: _bodyTextStyle()),
            SizedBox(height: 10),
            Text("📅 Posted On: ${job.createdAt.toLocal().toString().split(' ')[0]}",
                style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/apply', arguments: job.id);
                },
                icon: Icon(Icons.send),
                label: Text('Apply Now'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _sectionTitleStyle() {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple);
  }

  TextStyle _bodyTextStyle() {
    return TextStyle(fontSize: 14, color: Colors.black87, height: 1.4);
  }
}
