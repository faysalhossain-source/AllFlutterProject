
// job.dart
import '../DTO/dto.dart';

class Job {
  final int id;
  final String jobTitle;
  final CompanyDto company;
  final String jobDescription;
  final String jobRequirement;
  final String jobResponsibilities;
  final String compensationBenefit;
  final String workPlace;
  final String employmentStatus;
  final String jobLocation;
  final DateTime createdAt;

  Job({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.jobDescription,
    required this.jobRequirement,
    required this.jobResponsibilities,
    required this.compensationBenefit,
    required this.workPlace,
    required this.employmentStatus,
    required this.jobLocation,
    required this.createdAt,
  });


  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as int,
      jobTitle: json['jobTitle'] as String,
      company: CompanyDto.fromJson(json['company'] as Map<String, dynamic>), // nested object parsing
      jobDescription: json['jobDescription'] as String,
      jobRequirement: json['jobRequirement'] as String,
      jobResponsibilities: json['jobResponsibilities'] as String,
      compensationBenefit: json['compensationBenefit'] as String,
      workPlace: json['workPlace'] as String,
      employmentStatus: json['employmentStatus'] as String,
      jobLocation: json['jobLocation'] as String,
      // String from DateTime
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobTitle': jobTitle,
      'company': company.toJson(), // nested object to JSON
      'jobDescription': jobDescription,
      'jobRequirement': jobRequirement,
      'jobResponsibilities': jobResponsibilities,
      'compensationBenefit': compensationBenefit,
      'workPlace': workPlace,
      'employmentStatus': employmentStatus,
      'jobLocation': jobLocation,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}