import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login or Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle Login and navigate to Dashboard
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()));
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
