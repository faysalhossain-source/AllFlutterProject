import 'package:flutter_jobkhujibd/Models/Company.dart';
import 'package:flutter_jobkhujibd/Models/JobApply.dart';
// import 'package:flutter_jobkhujibd/Models/job_model.dart';
// import 'package:intl/intl.dart'; // For date parsing if needed, though handled in fromJson typically

class JobShortlist {
  final JobApply jobApply;
  final DateTime interviewDate;
  final DateTime shortlistedAt;
  final Company company;

  JobShortlist({
    required this.jobApply,
    required this.interviewDate,
    required this.shortlistedAt,
    required this.company,
  });

  factory JobShortlist.fromJson(Map<String, dynamic> json) {
    return JobShortlist(
      jobApply: JobApply.fromJson(json['jobApply']),
      interviewDate: DateTime.parse(json['interviewDate']),
      shortlistedAt: DateTime.parse(json['shortlistedAt']),
      company: Company.fromJson(json['company']),
    );
  }
}