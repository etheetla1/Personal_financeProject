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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Savings Goals")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(context, "Goal Amount", TextInputType.number,
                goalAmountController, screenHeight),
            SizedBox(height: screenHeight * 0.015),
            _buildTextField(context, "Goal Name", TextInputType.text,
                goalNameController, screenHeight),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: _addSavingsGoal,
              child: Text("Set Savings Goal"),
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
}
