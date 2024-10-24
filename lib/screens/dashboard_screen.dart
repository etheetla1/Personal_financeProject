import 'package:flutter/material.dart';
import '../db_helper.dart';

class DashboardScreen extends StatefulWidget {
  final int userId;

  DashboardScreen({required this.userId});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DBHelper dbHelper = DBHelper();
  List<Map<String, dynamic>> transactions = [];
  List<Map<String, dynamic>> budgets = [];
  List<Map<String, dynamic>> savingsGoals = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    try {
      transactions = await dbHelper.getUserTransactions(widget.userId);
      budgets = await dbHelper.getUserBudgets(widget.userId);
      savingsGoals = await dbHelper.getUserSavingsGoals(widget.userId);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading data: $e';
        isLoading = false;
      });
    }
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Logout button
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Transactions'),
                        transactions.isEmpty
                            ? Center(child: Text('No transactions available.'))
                            : _buildCardList(
                                transactions, 'amount', 'description'),
                        SizedBox(height: 20),
                        _buildSectionTitle('Budgets'),
                        budgets.isEmpty
                            ? Center(child: Text('No budgets available.'))
                            : _buildCardList(
                                budgets, 'category', 'budget_limit',
                                isBudget: true),
                        SizedBox(height: 20),
                        _buildSectionTitle('Savings Goals'),
                        savingsGoals.isEmpty
                            ? Center(child: Text('No savings goals available.'))
                            : _buildCardList(
                                savingsGoals, 'goal_name', 'goal_amount',
                                isSavings: true),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildCardList(
      List<Map<String, dynamic>> items, String titleKey, String subtitleKey,
      {bool isBudget = false, bool isSavings = false}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              isBudget
                  ? '${item[titleKey]}: \$${item[subtitleKey]}'
                  : '${item[titleKey]}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              isSavings
                  ? 'Goal: \$${item[subtitleKey]}'
                  : 'Spent: \$${item[subtitleKey]}',
              style: TextStyle(fontSize: 14),
            ),
          ),
        );
      },
    );
  }
}
