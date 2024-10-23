import 'package:flutter/material.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isLogin = true;

  // Toggle between login and signup forms
  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? "Login" : "Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email field
            _buildTextField("Email", false),
            SizedBox(height: 20),

            // Password field
            _buildTextField("Password", true),
            SizedBox(height: 20),

            // If in signup mode, show confirm password field
            if (!isLogin) _buildTextField("Confirm Password", true),
            SizedBox(height: 20),

            // Login or Sign up button
            ElevatedButton(
              onPressed: () {
                // Handle login or signup logic
              },
              child: Text(isLogin ? "Login" : "Sign Up"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),

            // Toggle between Login and Signup
            TextButton(
              onPressed: toggleForm,
              child: Text(
                isLogin
                    ? "Don't have an account? Sign Up"
                    : "Already have an account? Login",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A reusable method for building text fields
  Widget _buildTextField(String hint, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }
}
