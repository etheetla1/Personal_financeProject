import 'package:flutter/material.dart';
import '../db_helper.dart';

class IncomeExpenseScreen extends StatefulWidget {
  final int userId;

  IncomeExpenseScreen({required this.userId});

  @override
  _IncomeExpenseScreenState createState() => _IncomeExpenseScreenState();
}

class _IncomeExpenseScreenState extends State<IncomeExpenseScreen> {
  final DBHelper dbHelper = DBHelper();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedCategory = 'Income';

  void _addTransaction() async {
    double amount = double.tryParse(amountController.text) ?? 0;
    String description = descriptionController.text;

    if (amount > 0 && description.isNotEmpty) {
      await dbHelper.addTransaction(
          widget.userId, amount, description, selectedCategory);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transaction added successfully')));
      Navigator.pop(
          context); // Return to the dashboard after adding the transaction
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter valid data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Income & Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Transaction",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 20),
            _buildTextField(
                context, "Amount", TextInputType.number, amountController),
            SizedBox(height: 10),
            _buildTextField(context, "Description", TextInputType.text,
                descriptionController),
            SizedBox(height: 10),
            _buildCategoryDropdown(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTransaction,
              child: Text("Add Transaction"),
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

  Widget _buildTextField(BuildContext context, String hintText,
      TextInputType type, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
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
      items: <String>['Income', 'Expense'].map((String value) {
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
