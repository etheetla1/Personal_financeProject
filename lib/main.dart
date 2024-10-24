import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_signup.dart';
import 'screens/dashboard_screen.dart';
import 'screens/income_expense_screen.dart';
import 'screens/budget_screen.dart';
import 'screens/savings_goal_screen.dart';
import 'screens/profile_settings.dart';
import 'screens/edit_transaction_screen.dart';

void main() {
  runApp(FinanceManagerApp());
}

class FinanceManagerApp extends StatefulWidget {
  @override
  _FinanceManagerAppState createState() => _FinanceManagerAppState();
}

class _FinanceManagerAppState extends State<FinanceManagerApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  void _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = value;
      prefs.setBool('isDarkMode', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Manager',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => LoginSignupScreen(
                    toggleTheme: _toggleTheme, isDarkMode: isDarkMode));
          case '/dashboard':
            final int userId =
                settings.arguments as int; // Get userId from arguments
            return MaterialPageRoute(
                builder: (context) => DashboardScreen(userId: userId));
          case '/income_expense':
            final int userId = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => IncomeExpenseScreen(userId: userId));
          case '/budget':
            final int userId = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => BudgetScreen(userId: userId));
          case '/savings_goal':
            final int userId = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => SavingsGoalScreen(userId: userId));
          case '/profile_settings':
            final int userId = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => ProfileSettingsScreen(
                      toggleTheme: _toggleTheme,
                      isDarkMode: isDarkMode,
                      userId: userId,
                    ));
          case '/edit_transaction':
            final Map<String, dynamic> transaction =
                settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
                builder: (context) => EditTransactionScreen(
                      transaction: transaction,
                    ));
          default:
            return MaterialPageRoute(
                builder: (context) => LoginSignupScreen(
                      toggleTheme: _toggleTheme,
                      isDarkMode: isDarkMode,
                    ));
        }
      },
    );
  }
}
