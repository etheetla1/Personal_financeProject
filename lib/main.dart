import 'package:flutter/material.dart';
import 'screens/login_signup.dart';
import 'screens/dashboard_screen.dart';
import 'screens/profile_settings.dart';
import 'screens/income_expense_screen.dart';
import 'screens/budget_screen.dart';
import 'screens/savings_goal_screen.dart';

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
      // Setting the initial route to the login/signup screen
      initialRoute: '/',
      routes: {
        '/': (context) => LoginSignupScreen(), // Initial login/signup screen
        '/dashboard': (context) =>
            DashboardScreen(), // After login, the dashboard
        '/profile_settings': (context) =>
            ProfileSettingsScreen(), // Settings screen
        '/income_expense': (context) =>
            IncomeExpenseScreen(), // Income/Expense screen
        '/budget': (context) => BudgetScreen(), // Budget management screen
        '/savings_goal': (context) =>
            SavingsGoalScreen(), // Savings goal screen
      },
    );
  }
}
