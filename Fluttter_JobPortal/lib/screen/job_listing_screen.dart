import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart'; // For date formatting

// Make sure you have these model classes defined and imported
// For example, in lib/models/job.dart and lib/models/company_dto.dart


import '../model/job.dart';
import '../service/api_service.dart'; // Your API service to fetch data

class JobListingScreen extends StatefulWidget {
  const JobListingScreen({super.key});

  @override
  State<JobListingScreen> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<JobListingScreen> {
  final ApiService apiService = ApiService();
  List<Job> jobs = [];
  bool isLoading = true; // Added loading state

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedJobs = await apiService.getAllJobs();
      setState(() {
        jobs = fetchedJobs;
        isLoading = false;

      });
    } catch (e) {
      print('Failed to load jobs: $e');
      setState(() {
        isLoading = false; // Set loading to false even if there's an error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load jobs: $e')),
      );
    }
  }

  void addToFavorites(Job job) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added "${job.jobTitle}" to favorites.')),
    );
    // Here you would typically send this to a backend service
    // apiService.addJobToFavorites(job.id);
  }

  void applyToJob(int id) async {
    final jobId = id;
    // You'll need to fetch the seekerId from your app's local storage or authentication system
    // For example, using shared_preferences or a state management solution
    final seekerId = 123; // Placeholder: Replace with actual seeker ID

    try {
      await apiService.applyJob({'seekerId': seekerId, 'jobId': jobId});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Applied Successfully!')),
      );
    } catch (e) {
      print('Error applying for job: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Oops! Failed to apply. Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       //AppBar can be managed by the parent Dashboard or added here if this is a standalone screen
      appBar: AppBar(
        title: const Text('Job Listings'),
        backgroundColor: Colors.blue.shade700,
         foregroundColor: Colors.white,
       ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          : jobs.isEmpty
          ? const Center(child: Text('No jobs found.')) // Message if no jobs are available
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: jobs.map((job) {
            return Card(
              margin: const EdgeInsets.only(bottom: 24.0),
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Job Title, Company, and Badges ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const FaIcon(FontAwesomeIcons.briefcase,
                                      color: Colors.blue, size: 18),
                                  const SizedBox(width: 8),
                                  Flexible( // Use Flexible to prevent overflow for long titles
                                    child: Text(
                                      job.jobTitle,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade700,
                                      ),
                                      overflow: TextOverflow.ellipsis, // Add ellipsis if text is too long
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const FaIcon(FontAwesomeIcons.building,
                                      color: Colors.grey, size: 16),
                                  const SizedBox(width: 8),
                                  Flexible( // Use Flexible for company name too
                                    child: Text(
                                      job.company.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Chip(
                              label: Text(job.employmentStatus,
                                  style: const TextStyle(color: Colors.white)),
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            ),
                            const SizedBox(height: 4),
                            Chip(
                              label: Text(job.workPlace,
                                  style: const TextStyle(color: Colors.black)),
                              backgroundColor: Colors.lightBlue.shade100,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Divider(height: 30, thickness: 1),

                    // --- Job Details (Description, Requirements, Responsibilities, Benefits) ---
                    _buildDetailSection(
                      FontAwesomeIcons.alignLeft,
                      "Description",
                      job.jobDescription,
                    ),
                    _buildDetailSection(
                      FontAwesomeIcons.userGraduate,
                      "Requirements",
                      job.jobRequirement,
                    ),
                    _buildDetailSection(
                      FontAwesomeIcons.tasks,
                      "Responsibilities",
                      job.jobResponsibilities,
                    ),
                    _buildDetailSection(
                      FontAwesomeIcons.gift,
                      "Benefits",
                      job.compensationBenefit,
                    ),

                    const SizedBox(height: 16),

                    // --- Location, Phone, Posted At ---
                    _buildInfoRow(
                      FontAwesomeIcons.mapMarkerAlt,
                      Colors.red,
                      "Location:",
                      job.jobLocation,
                    ),
                    _buildInfoRow(
                      FontAwesomeIcons.phone,
                      Colors.lightBlue,
                      "Phone:",
                      job.company.phone,
                    ),
                    _buildInfoRow(
                      FontAwesomeIcons.calendarAlt,
                      Colors.orange,
                      "Posted:",
                      DateFormat('medium').format(job.createdAt), // Format DateTime
                    ),

                    const SizedBox(height: 24),

                    // --- Action Buttons ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => addToFavorites(job),
                          icon: const FaIcon(FontAwesomeIcons.heart, size: 18),
                          label: const Text('Favorite'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () => applyToJob(job.id),
                          icon: const FaIcon(FontAwesomeIcons.paperPlane, size: 18),
                          label: const Text('Apply Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Helper widget for Description, Requirements, Responsibilities, Benefits sections
  Widget _buildDetailSection(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(icon, color: Colors.grey.shade600, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // Helper widget for Location, Phone, Posted At rows
  Widget _buildInfoRow(
      IconData icon, Color iconColor, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          FaIcon(icon, color: iconColor, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded( // Use Expanded to ensure text doesn't overflow
            child: Text(value),
          ),
        ],
      ),
    );
  }
}