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
  TextEditingController goalController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  // Add savings goal to the database
  void _addSavingsGoal() async {
    double goalAmount = double.tryParse(amountController.text) ?? 0;
    String goalName = goalController.text;

    if (goalAmount > 0 && goalName.isNotEmpty) {
      // Ensure the correct method from db_helper.dart is called
      await dbHelper.addSavingsGoal(widget.userId, goalName, goalAmount, 0.0);

      // Notify the user with a success message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Savings goal added successfully')));

      // Return true to indicate data was added and the dashboard should reload
      Navigator.pop(context, true);
    } else {
      // Notify the user if the input is invalid
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter valid data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Savings Goal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set Savings Goal",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.03,
                  ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField("Goal Name", goalController, screenHeight),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField("Goal Amount", amountController, screenHeight,
                keyboardType: TextInputType.number), // Accept only numbers
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: ElevatedButton(
                onPressed: _addSavingsGoal,
                child: Text("Add Goal"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.3),
                  textStyle: TextStyle(fontSize: screenHeight * 0.02),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Text field builder
  Widget _buildTextField(
      String hint, TextEditingController controller, double screenHeight,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: screenHeight * 0.015),
      ),
    );
  }
}
