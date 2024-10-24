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
    return Scaffold(
      appBar: AppBar(title: Text("Manage Budget")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: budgetAmountController,
              decoration: InputDecoration(labelText: "Budget Amount"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            _buildCategoryDropdown(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addBudget,
              child: Text("Set Budget"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
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
