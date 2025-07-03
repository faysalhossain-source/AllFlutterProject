import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../model/User.dart';
import 'edit_profile_modal.dart';
 // Import your User model

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Dummy user data
  User _user = User(
    id: '12345',
    name: 'John Doe',
    email: 'john.doe@example.com',
    education: 'MSc in Computer Science',
    jobExperience: '5 years',
    designation: 'Senior Software Engineer',
    phone: '+1 (555) 123-4567',
    address: '123 Main St, Anytown, USA',
    createdAt: DateTime.now().subtract(const Duration(days: 365)),
  );

  void _openEditModal() async {
    final updatedUser = await showDialog<User>(
      context: context,
      builder: (BuildContext context) {
        return EditProfileModal(user: _user);
      },
    );

    if (updatedUser != null) {
      setState(() {
        _user = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.user, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      _user.name ?? 'N/A',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.envelope, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      _user.email ?? 'N/A',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const Divider(height: 24, thickness: 1),
                _buildInfoRow('ID:', _user.id),
                _buildInfoRow('Education:', _user.education),
                _buildInfoRow('Experience:', _user.jobExperience),
                _buildInfoRow('Designation:', _user.designation),
                _buildInfoRow('Phone:', _user.phone),
                _buildInfoRow('Address:', _user.address),
                _buildInfoRow(
                  'Created At:',
                  _user.createdAt != null
                      ? DateFormat.yMMMd().add_jm().format(_user.createdAt!)
                      : 'N/A',
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton.icon(
                    onPressed: _openEditModal,
                    icon: const FaIcon(FontAwesomeIcons.edit),
                    label: const Text('Edit'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100, // Adjust width as needed for labels
            child: Text(
              '$label ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value ?? 'N/A'),
          ),
        ],
      ),
    );
  }
}

