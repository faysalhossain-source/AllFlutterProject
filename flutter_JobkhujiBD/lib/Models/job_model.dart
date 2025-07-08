import 'Company.dart';

class Job {
  final String jobTitle;
  final Company company;
  final String employmentStatus;
  final String workPlace;
  final String jobDescription;
  final String jobRequirement;
  final String jobResponsibilities;
  final String compensationBenefit;
  final String jobLocation;
  final DateTime createdAt;
  final int id;

  Job({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.employmentStatus,
    required this.workPlace,
    required this.jobDescription,
    required this.jobRequirement,
    required this.jobResponsibilities,
    required this.compensationBenefit,
    required this.jobLocation,
    required this.createdAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as int, // Assuming 'id' field exists
      jobTitle: json['jobTitle'] as String,
      company: Company.fromJson(json['company']),
      employmentStatus: json['employmentStatus'] as String,
      workPlace: json['workPlace'] as String,
      jobDescription: json['jobDescription'] as String,
      jobRequirement: json['jobRequirement'] as String,
      jobResponsibilities: json['jobResponsibilities'] as String,
      compensationBenefit: json['compensationBenefit'] as String,
      jobLocation: json['jobLocation'] as String,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
