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

  void _openSettings() {
    Navigator.pushNamed(context, '/profile_settings', arguments: widget.userId);
  }

  // Function to display the bottom sheet for selecting an action
  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height *
              0.3, // Adjust based on screen size
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Action",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: Icon(Icons.monetization_on),
                title: Text("Add Income or Expense"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/income_expense',
                      arguments: widget.userId);
                },
              ),
              ListTile(
                leading: Icon(Icons.pie_chart),
                title: Text("Add Budget"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/budget',
                      arguments: widget.userId);
                },
              ),
              ListTile(
                leading: Icon(Icons.savings),
                title: Text("Add Savings Goal"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/savings_goal',
                      arguments: widget.userId);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openSettings, // Settings button
          ),
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
                        _buildSectionTitle('Transactions', screenHeight),
                        transactions.isEmpty
                            ? _buildEmptyState('No transactions available.',
                                '/income_expense', screenHeight, screenWidth)
                            : _buildCardList(transactions, 'amount',
                                'description', screenHeight,
                                isTransaction: true),
                        SizedBox(height: 20),
                        _buildSectionTitle('Budgets', screenHeight),
                        budgets.isEmpty
                            ? _buildEmptyState('No budgets available.',
                                '/budget', screenHeight, screenWidth)
                            : _buildCardList(budgets, 'budget_limit',
                                'category', screenHeight,
                                isBudget: true),
                        SizedBox(height: 20),
                        _buildSectionTitle('Savings Goals', screenHeight),
                        savingsGoals.isEmpty
                            ? _buildEmptyState('No savings goals available.',
                                '/savings_goal', screenHeight, screenWidth)
                            : _buildCardList(savingsGoals, 'goal_amount',
                                'goal_name', screenHeight,
                                isSavings: true),
                      ],
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _showAddOptions, // Show options to add Income/Expense, Budget, or Savings Goal
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget _buildSectionTitle(String title, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenHeight * 0.03, // Dynamic font size
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  // Only show the dollar symbol for amounts
  Widget _buildCardList(List<Map<String, dynamic>> items, String amountKey,
      String titleKey, double screenHeight,
      {bool isBudget = false,
      bool isSavings = false,
      bool isTransaction = false}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01), // Dynamic margin
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            contentPadding:
                EdgeInsets.all(screenHeight * 0.02), // Dynamic padding
            title: Text(
              '${item[titleKey]}', // Do not add $ for descriptions or categories
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenHeight * 0.022, // Dynamic font size
              ),
            ),
            subtitle: Text(
              // Show dollar symbol only for amounts
              isBudget || isSavings || isTransaction
                  ? 'Amount: \$${item[amountKey]}' // Dollar only for amounts
                  : '${item[amountKey]}',
              style:
                  TextStyle(fontSize: screenHeight * 0.02), // Dynamic font size
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String message, String routeName, double screenHeight,
      double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight * 0.05), // Dynamic spacing
        Center(
          child: Text(
            message,
            style: TextStyle(
              fontSize: screenHeight * 0.02,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02), // Dynamic spacing
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, routeName, arguments: widget.userId);
          },
          child: Text('Add Now'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.1), // Dynamic button size
            textStyle: TextStyle(fontSize: screenHeight * 0.02),
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rectangular shape
            ),
          ),
        ),
      ],
    );
  }
}
