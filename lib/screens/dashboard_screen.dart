import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        elevation: 4,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Adding padding to the entire screen
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Financial Overview',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 20),
            _buildCard(
              context,
              title: "Income & Expenses",
              subtitle: "Summary of your financial activities",
              icon: Icons.pie_chart,
              onTap: () {
                Navigator.pushNamed(context, '/income_expense');
              },
            ),
            _buildCard(
              context,
              title: "Budget Management",
              subtitle: "Manage your budgets",
              icon: Icons.money,
              onTap: () {
                Navigator.pushNamed(context, '/budget');
              },
            ),
            _buildCard(
              context,
              title: "Savings Goals",
              subtitle: "Track your savings progress",
              icon: Icons.savings,
              onTap: () {
                Navigator.pushNamed(context, '/savings_goal');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable method to build a consistent Card design for the dashboard
  Widget _buildCard(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor, size: 40),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
