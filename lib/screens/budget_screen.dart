import 'package:flutter/material.dart';
import '../db_helper.dart';

class BudgetScreen extends StatefulWidget {
  final int userId;

  BudgetScreen({required this.userId});

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final DBHelper dbHelper = DBHelper();
  TextEditingController budgetAmountController = TextEditingController();
  String selectedCategory = 'Groceries';

  void _addBudget() async {
    double budgetLimit = double.tryParse(budgetAmountController.text) ?? 0;

    if (budgetLimit > 0) {
      await dbHelper.addBudget(widget.userId, selectedCategory, budgetLimit);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Budget added successfully')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter a valid amount')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Manage Budget")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(context, "Budget Amount", TextInputType.number,
                budgetAmountController, screenHeight),
            SizedBox(height: screenHeight * 0.015),
            _buildCategoryDropdown(screenHeight),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: _addBudget,
              child: Text("Set Budget"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.1), // Dynamic button size
                textStyle: TextStyle(fontSize: screenHeight * 0.02),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Rectangular button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      BuildContext context,
      String hintText,
      TextInputType type,
      TextEditingController controller,
      double screenHeight) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: screenHeight * 0.015), // Dynamic padding
      ),
    );
  }

  Widget _buildCategoryDropdown(double screenHeight) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: screenHeight * 0.015), // Dynamic padding
      ),
      value: selectedCategory,
      items: <String>['Groceries', 'Rent', 'Utilities', 'Others']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedCategory = newValue!;
        });
      },
    );
  }
}
