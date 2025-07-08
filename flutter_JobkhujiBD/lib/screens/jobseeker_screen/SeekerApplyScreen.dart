import 'package:flutter/material.dart';
import 'package:flutter_jobkhujibd/services/seeker_service.dart';
import 'package:flutter_jobkhujibd/Models/JobApply.dart';
import 'package:intl/intl.dart';

class SeekerApplyScreen extends StatefulWidget {
  const SeekerApplyScreen({super.key});

  @override
  State<SeekerApplyScreen> createState() => _SeekerApplyScreenState();
}

class _SeekerApplyScreenState extends State<SeekerApplyScreen> {
  List<JobApply> appliedJobs = [];
  bool isLoading = true;
  String? errorMsg;

  final SeekerService _seekerService = SeekerService();
  final int seekerId = 1; //  তুমি যেভাবে লগইন ইউজার track করো, সেটার ID বসাও

  @override
  void initState() {
    super.initState();
    fetchAppliedJobs();
  }

  Future<void> fetchAppliedJobs() async {
    try {
      // ignore: unused_local_variable
      final jobs = await _seekerService.getMyAppliedJobs(seekerId);
      setState(() {
        // appliedJobs = jobs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMsg = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Applied Jobs"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMsg != null
          ? Center(child: Text('Error: $errorMsg', style: TextStyle(color: Colors.red)))
          : appliedJobs.isEmpty
          ? const Center(child: Text("You haven't applied to any jobs yet."))
          : ListView.builder(
        itemCount: appliedJobs.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final job = appliedJobs[index].job;
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.jobTitle,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800])),
                  const SizedBox(height: 4),
                  Text(job.company.name,
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18, color: Colors.deepPurple),
                      const SizedBox(width: 6),
                      Text(
                        'Applied on: ${DateFormat('yMMMd').format(appliedJobs[index].createdAt)}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 18),
                      const SizedBox(width: 6),
                      Text(job.jobLocation),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Chip(
                    label: Text(job.employmentStatus),
                    backgroundColor: Colors.green.shade100,
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
