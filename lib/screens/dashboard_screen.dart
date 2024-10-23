import 'package:flutter/material.dart';
import 'income_expense_screen.dart';
import 'budget_screen.dart';
import 'savings_goal_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/profile_settings');
            },
          )
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Income & Expenses"),
            subtitle: Text("Summary of your financial activities"),
            trailing: Icon(Icons.add),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IncomeExpenseScreen()));
            },
          ),
          ListTile(
            title: Text("Budget Management"),
            subtitle: Text("Manage your budgets"),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BudgetScreen()));
            },
          ),
          ListTile(
            title: Text("Savings Goals"),
            subtitle: Text("Track your savings progress"),
            trailing: Icon(Icons.savings),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SavingsGoalScreen()));
            },
          ),
        ],
      ),
    );
  }
}
