import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/seeker_service.dart';

class SeekerProfileScreen extends StatefulWidget {
  const SeekerProfileScreen({super.key});

  @override
  State<SeekerProfileScreen> createState() => _SeekerProfileScreenState();
}

class _SeekerProfileScreenState extends State<SeekerProfileScreen> {
  Map<String, dynamic>? user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await SeekerService().getMyProfileInfo();
    setState(() {
      user = data;
    });
  }

  void openEditModal() {
    if (user != null) {
      _nameController.text = user!['name'] ?? '';
      _educationController.text = user!['education'] ?? '';
      _experienceController.text = user!['jobExperience'] ?? '';
      _designationController.text = user!['designation'] ?? '';
      _phoneController.text = user!['phone'] ?? '';
      _addressController.text = user!['address'] ?? '';

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
                  TextFormField(controller: _educationController, decoration: const InputDecoration(labelText: 'Education')),
                  TextFormField(controller: _experienceController, decoration: const InputDecoration(labelText: 'Experience')),
                  TextFormField(controller: _designationController, decoration: const InputDecoration(labelText: 'Designation')),
                  TextFormField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone')),
                  TextFormField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(onPressed: saveChanges, child: const Text('Save')),
          ],
        ),
      );
    }
  }

  void saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        'id': user!['id'],
        'name': _nameController.text,
        'education': _educationController.text,
        'jobExperience': _experienceController.text,
        'designation': _designationController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
      };

      final result = await SeekerService().editProfileInfo(updatedData);
      if (result != null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Profile updated successfully')),
        );
        loadProfile();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Failed to update profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seeker Profile')),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("👤 Name: ${user!['name']}", style: const TextStyle(fontSize: 18)),
                Text("📧 Email: ${user!['email']}", style: const TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 10),
                Text("🎓 Education: ${user!['education']}"),
                Text("💼 Experience: ${user!['jobExperience']}"),
                Text("🏢 Designation: ${user!['designation']}"),
                Text("📱 Phone: ${user!['phone']}"),
                Text("🏠 Address: ${user!['address']}"),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: openEditModal,
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
