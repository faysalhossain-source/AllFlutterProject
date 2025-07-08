import 'package:flutter_jobkhujibd/Models/JobSeeker.dart';
import 'package:flutter_jobkhujibd/Models/job_model.dart';

class JobApply {
  final Job job;
  final JobSeeker jobSeeker;
  final DateTime createdAt;// If you uncomment the applicant info

  JobApply({
    required this.job,
    required this.jobSeeker,
    required this.createdAt,
  });

  factory JobApply.fromJson(Map<String, dynamic> json) {
    return JobApply(
      job: Job.fromJson(json['job']),
      jobSeeker: JobSeeker.fromJson(json['jobSeeker']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}