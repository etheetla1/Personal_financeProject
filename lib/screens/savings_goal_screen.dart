import 'package:flutter/material.dart';
import '../db_helper.dart';

class SavingsGoalScreen extends StatefulWidget {
  final int userId;

  SavingsGoalScreen({required this.userId});

  @override
  _SavingsGoalScreenState createState() => _SavingsGoalScreenState();
}

class _SavingsGoalScreenState extends State<SavingsGoalScreen> {
  final DBHelper dbHelper = DBHelper();
  TextEditingController goalAmountController = TextEditingController();
  TextEditingController goalNameController = TextEditingController();

  void _addSavingsGoal() async {
    double goalAmount = double.tryParse(goalAmountController.text) ?? 0;
    String goalName = goalNameController.text;

    if (goalAmount > 0 && goalName.isNotEmpty) {
      await dbHelper.addSavingsGoal(widget.userId, goalName, goalAmount);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Savings goal added successfully')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter valid data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Savings Goals")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: goalAmountController,
              decoration: InputDecoration(labelText: "Goal Amount"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: goalNameController,
              decoration: InputDecoration(labelText: "Goal Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addSavingsGoal,
              child: Text("Set Savings Goal"),
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
}
