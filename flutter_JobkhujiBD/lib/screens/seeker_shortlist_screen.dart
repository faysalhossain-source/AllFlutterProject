// seeker_shortlist_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_jobkhujibd/Models/JobShortlist.dart';
import 'package:flutter_jobkhujibd/services/seeker_service.dart';
import 'package:intl/intl.dart';

class SeekerShortlistScreen extends StatefulWidget {
  const SeekerShortlistScreen({super.key});

  @override
  State<SeekerShortlistScreen> createState() => _SeekerShortlistScreenState();
}

class _SeekerShortlistScreenState extends State<SeekerShortlistScreen> {
  List<JobShortlist> jobs = [];
  bool isLoading = true;
  String? errorMessage;
  final SeekerService _seekerService = SeekerService();

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final fetchedJobsDynamic =
      await _seekerService.getShortlistMyAppliedJob();

      final List<JobShortlist> fetchedJobs = fetchedJobsDynamic
          .map((jobJson) => JobShortlist.fromJson(jobJson))
          .toList();

      setState(() {
        jobs = fetchedJobs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shortlisted Jobs'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : jobs.isEmpty
          ? const Center(
        child: Text('No shortlisted jobs found.'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final item = jobs[index];
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.only(bottom: 24.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.jobApply.job.jobTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              item.jobApply.job.company.name,
                              style: const TextStyle(
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          Chip(
                            label: Text(item.jobApply.job
                                .employmentStatus),
                            backgroundColor: Colors.green[100],
                            labelStyle: const TextStyle(
                                color: Colors.green),
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                          ),
                          const SizedBox(height: 8.0),
                          Chip(
                            label: Text(
                                item.jobApply.job.workPlace),
                            backgroundColor: Colors.blue[100],
                            labelStyle: const TextStyle(
                                color: Colors.blue),
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 32.0),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Interview Schedule',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.black87),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                color: Colors.blue, size: 20),
                            const SizedBox(width: 8.0),
                            Text(
                              'Date: ${DateFormat('fullDate').format(item.interviewDate)} at ${DateFormat('jm').format(item.interviewDate)}',
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Icon(Icons.check_circle_outline,
                                color: Colors.lightBlue,
                                size: 20),
                            const SizedBox(width: 8.0),
                            Text(
                              'Shortlisted At: ${DateFormat('medium').format(item.shortlistedAt)}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall,
                            ),
                            Text(item
                                .jobApply.job.jobDescription),
                            const SizedBox(height: 8.0),
                            Text(
                              'Responsibilities:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall,
                            ),
                            Text(item.jobApply.job
                                .jobResponsibilities),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Requirements:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall,
                            ),
                            Text(item.jobApply.job
                                .jobRequirement),
                            const SizedBox(height: 8.0),
                            Text(
                              'Benefits:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall,
                            ),
                            Text(item.jobApply.job
                                .compensationBenefit),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32.0),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colors.red, size: 18),
                              const SizedBox(width: 8.0),
                              Text(
                                  'Company Address: ${item.company.address}'),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(Icons.phone,
                                  color: Colors.blueGrey,
                                  size: 18),
                              const SizedBox(width: 8.0),
                              Text(
                                  'Contact: ${item.company.phone}'),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        // ignore: unnecessary_cast
                        'Posted: ${DateFormat('medium').format(item.jobApply.job.createdAt as DateTime)}',
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 12.0),
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
