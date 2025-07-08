class JobSeeker {
  final String name;
  final String email;
  final String phone;
  final String education;
  final String jobExperience;
  final String designation;
  final String address;

  JobSeeker({
    required this.name,
    required this.email,
    required this.phone,
    required this.education,
    required this.jobExperience,
    required this.designation,
    required this.address,
  });

  factory JobSeeker.fromJson(Map<String, dynamic> json) {
    return JobSeeker(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      education: json['education'],
      jobExperience: json['jobExperience'],
      designation: json['designation'],
      address: json['address'],
    );
  }
}