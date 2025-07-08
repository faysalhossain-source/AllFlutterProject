class Company {
  final String name;
  final String phone;
  final String address;

  Company({
    required this.name,
    required this.phone,
    required this.address,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] as String,
      phone: json['phone'] as String,
       address: json['address'] as String,
    );
  }
}
