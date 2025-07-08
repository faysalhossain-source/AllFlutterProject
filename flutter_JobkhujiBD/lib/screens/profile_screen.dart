// import 'package:flutter/material.dart';
// import '../services/seeker_service.dart';
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final SeekerService _seekerService = SeekerService();
//
//   Map<String, dynamic>? profile;
//   bool isLoading = true;
//   final _formKey = GlobalKey<FormState>();
//
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final currentPasswordController = TextEditingController();
//   final newPasswordController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }
//
//   void loadProfile() async {
//     try {
//       int seekerId = 1; // Normally from localStorage or SharedPreferences
//       final data = await _seekerService.getMyProfileInfo(seekerId);
//       setState(() {
//         profile = data;
//         nameController.text = data['fullName'] ?? '';
//         emailController.text = data['email'] ?? '';
//         isLoading = false;
//       });
//     } catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   void updateProfile() async {
//     if (_formKey.currentState!.validate()) {
//       final updatedData = {
//         "id": profile!['id'],
//         "fullName": nameController.text,
//         "email": emailController.text,
//       };
//       await _seekerService.editProfileInfo(updatedData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Profile updated successfully')),
//       );
//     }
//   }
//
//   void changePassword() async {
//     await _seekerService.changePassword(
//       id: profile!['id'],
//       currentPassword: currentPasswordController.text,
//       newPassword: newPasswordController.text,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Password changed successfully')),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Seeker Profile'), centerTitle: true),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Text("Profile Info", style: TextStyle(fontSize: 20)),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(labelText: 'Full Name'),
//                 validator: (value) =>
//                 value!.isEmpty ? 'Name required' : null,
//               ),
//               TextFormField(
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) =>
//                 value!.isEmpty ? 'Email required' : null,
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: updateProfile,
//                 child: Text('Update Profile'),
//               ),
//               Divider(height: 40),
//               Text("Change Password", style: TextStyle(fontSize: 20)),
//               SizedBox(height: 16),
//               TextField(
//                 controller: currentPasswordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: 'Current Password'),
//               ),
//               TextField(
//                 controller: newPasswordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: 'New Password'),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: changePassword,
//                 child: Text('Change Password'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
