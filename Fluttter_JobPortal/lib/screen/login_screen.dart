import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:jobportal/screen/dashboard_screen.dart';

// Consider creating separate files for your pages (e.g., login_screen.dart, register_company_screen.dart)
// and for authentication services.

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with login logic
      print('Email: ${_emailController.text}');

      print('Password: ${_passwordController.text}');

      // Simulate a successful login after a short delay
      // In a real app, you would call your authentication service here
      // and handle actual API responses.
      Future.delayed(const Duration(seconds: 2), () {
        // Assume login is successful for now
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful! Navigating...')),
        );

        // Navigate to JobPortalDashboard and replace the current route
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const JobPortalDashboard()),
        );
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email address',
                          hintText: 'example@domain.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.people),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          hintText: 'At least 6 characters',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Minimum 6 characters required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _onLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Registration Links
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RegisterCompanyScreen()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.deepPurple,
                                side: const BorderSide(color: Colors.deepPurple),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Register as Company',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RegisterSeekerScreen()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.deepPurple,
                                side: const BorderSide(color: Colors.deepPurple),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Register as Job Seeker',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- Placeholder for Registration Screens ---
// In a real app, these would be in their own files
class RegisterCompanyScreen extends StatelessWidget {
  const RegisterCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Company')),
      body: const Center(
        child: Text('Company Registration Form'),
      ),
    );
  }
}

class RegisterSeekerScreen extends StatelessWidget {
  const RegisterSeekerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Job Seeker')),
      body: const Center(
        child: Text('Job Seeker Registration Form'),
      ),
    );
  }
}