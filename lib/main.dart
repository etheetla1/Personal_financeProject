import 'package:flutter/material.dart';
import 'screens/login_signup.dart';
import 'screens/dashboard_screen.dart';
import 'screens/profile_settings.dart';

void main() {
  runApp(FinanceManagerApp());
}

class FinanceManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Manager',
      theme: ThemeData(
        brightness: Brightness.dark, // Default to dark mode
      ),
      // Using named routes allows easy navigation and more scalable management of screens.
      initialRoute:
          '/', // This can be set to your initial screen (login/signup)
      routes: {
        '/': (context) => LoginSignupScreen(), // Initial route
        '/dashboard': (context) => DashboardScreen(),
        '/profile_settings': (context) => ProfileSettingsScreen(),
      },
    );
  }
}
