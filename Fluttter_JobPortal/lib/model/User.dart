class User {
  final String? id;
  final String? name;
  final String? email;
  final String? education;
  final String? jobExperience;
  final String? designation;
  final String? phone;
  final String? address;
  final DateTime? createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.education,
    this.jobExperience,
    this.designation,
    this.phone,
    this.address,
    this.createdAt,
  });


  User copyWith({
    String? id,
    String? name,
    String? email,
    String? education,
    String? jobExperience,
    String? designation,
    String? phone,
    String? address,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      education: education ?? this.education,
      jobExperience: jobExperience ?? this.jobExperience,
      designation: designation ?? this.designation,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}