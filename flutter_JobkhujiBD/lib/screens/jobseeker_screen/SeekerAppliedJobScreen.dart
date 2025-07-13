// lib/screens/jobseeker_screen/SeekerAppliedJobScreen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Models/JobApply.dart';
import '../../services/AppliedJobService.dart'; // ✅ Correct import

class SeekerAppliedJobScreen extends StatefulWidget {
  const SeekerAppliedJobScreen({super.key});

  @override
  State<SeekerAppliedJobScreen> createState() => _SeekerAppliedJobScreenState();
}

class _SeekerAppliedJobScreenState extends State<SeekerAppliedJobScreen> {
  final AppliedJobService _appliedJobService = AppliedJobService(); // ✅ Correct service used
  List<JobApply> appliedJobs = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadAppliedJobs();
  }

  Future<void> _loadAppliedJobs() async {
    try {
      final fetchedJobs = await _appliedJobService.getMyAppliedJobs(); // ✅ Correct call
      final List<JobApply> jobList =
      fetchedJobs.map<JobApply>((json) => JobApply.fromJson(json)).toList();

      setState(() {
        appliedJobs = jobList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applied Jobs'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text('Error: $error'))
          : appliedJobs.isEmpty
          ? const Center(child: Text('No applied jobs found.'))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: appliedJobs.length,
        itemBuilder: (context, index) {
          final job = appliedJobs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.job.jobTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    job.job.company.name,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        'Applied on: ${DateFormat.yMMMd().format(job.createdAt)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
