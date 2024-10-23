import 'package:flutter/material.dart';
import '../db_helper.dart'; // Import the DBHelper class

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isLogin = true; // Initial state is for login
  String email = '';
  String password = '';
  String confirmPassword = '';

  final DBHelper dbHelper = DBHelper(); // Instantiate the DBHelper class

  // Toggle between login and signup forms
  void toggleForm() {
    setState(() {
      isLogin = !isLogin; // Switch between login and signup form
    });
  }

  // Register user to the database
  void registerUser() async {
    if (password == confirmPassword) {
      await dbHelper.registerUser(email, password);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User registered successfully!')));
      toggleForm(); // Switch back to login after successful signup
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Passwords do not match')));
    }
  }

  // Login user by checking the database
  void loginUser() async {
    var user = await dbHelper.loginUser(email, password);
    if (user != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login successful')));
      Navigator.pushReplacementNamed(
          context, '/dashboard'); // Navigate to dashboard on login success
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid credentials')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Ensure background is dark for dark mode
      appBar: AppBar(
        title: Text(isLogin ? "Login" : "Sign Up"),
        backgroundColor: Colors.grey[900], // Darker AppBar color for dark mode
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email field
            _buildTextField("Email", false, (value) => email = value),
            SizedBox(height: 20),

            // Password field
            _buildTextField("Password", true, (value) => password = value),
            SizedBox(height: 20),

            // If in signup mode, show confirm password field
            if (!isLogin)
              _buildTextField(
                  "Confirm Password", true, (value) => confirmPassword = value),
            SizedBox(height: 20),

            // Login or Sign up button
            ElevatedButton(
              onPressed: () {
                if (isLogin) {
                  loginUser(); // Handle login
                } else {
                  registerUser(); // Handle signup
                }
              },
              child: Text(isLogin ? "Login" : "Sign Up"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18),
                backgroundColor: Colors
                    .tealAccent[700], // Use backgroundColor instead of primary
              ),
            ),

            // Toggle between Login and Signup
            TextButton(
              onPressed: toggleForm, // Trigger toggle between forms
              child: Text(
                isLogin
                    ? "Don't have an account? Sign Up"
                    : "Already have an account? Login",
                style: TextStyle(
                    color:
                        Colors.tealAccent[700]), // Brighter text for dark mode
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A reusable method for building text fields with dark mode support
  Widget _buildTextField(
      String hint, bool isPassword, Function(String) onChanged) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(
          color: Colors.white), // Ensure text color is white for dark mode
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.grey[400]), // Subtle hint color for dark mode
        filled: true,
        fillColor: Colors.grey[800], // Dark fill color for text fields
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide.none, // No border for a clean look in dark mode
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
      onChanged: onChanged,
    );
  }
}
