// json.decode ব্যবহার করার জন্য এটি প্রয়োজন
import 'dart:convert';

class SeekerProfile {
  final String id;
  final String name;
  final String email;
  final int age;

  SeekerProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
  });

  factory SeekerProfile.fromJson(Map<String, dynamic> json) {
    return SeekerProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
    };
  }
}