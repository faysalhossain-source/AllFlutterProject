import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/User.dart';


// Import your User model

class EditProfileModal extends StatefulWidget {
  final User user;

  const EditProfileModal({super.key, required this.user});

  @override
  State<EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  late TextEditingController _nameController;
  late TextEditingController _educationController;
  late TextEditingController _jobExperienceController;
  late TextEditingController _designationController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  final _formKey = GlobalKey<FormState>(); // Key for form validation

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _educationController = TextEditingController(text: widget.user.education);
    _jobExperienceController = TextEditingController(text: widget.user.jobExperience);
    _designationController = TextEditingController(text: widget.user.designation);
    _phoneController = TextEditingController(text: widget.user.phone);
    _addressController = TextEditingController(text: widget.user.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _educationController.dispose();
    _jobExperienceController.dispose();
    _designationController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final updatedUser = widget.user.copyWith(
        name: _nameController.text,
        education: _educationController.text,
        jobExperience: _jobExperienceController.text,
        designation: _designationController.text,
        phone: _phoneController.text,
        address: _addressController.text,
      );
      Navigator.of(context).pop(updatedUser); // Return the updated user
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          FaIcon(FontAwesomeIcons.edit),
          SizedBox(width: 10),
          Text('Edit Profile'),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('Name', _nameController),
              _buildTextField('Education', _educationController),
              _buildTextField('Experience', _jobExperienceController),
              _buildTextField('Designation', _designationController),
              _buildTextField('Phone', _phoneController),
              _buildTextField('Address', _addressController, maxLines: 3),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cancel
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveChanges,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text('Save Changes'),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}