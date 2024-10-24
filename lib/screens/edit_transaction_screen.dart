import 'package:flutter/material.dart';
import '../db_helper.dart';

class EditTransactionScreen extends StatefulWidget {
  final Map<String, dynamic> transaction; // Pass the transaction data

  EditTransactionScreen({required this.transaction});

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final DBHelper dbHelper = DBHelper();
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  String selectedCategory = 'Income'; // Default

  @override
  void initState() {
    super.initState();
    amountController =
        TextEditingController(text: widget.transaction['amount'].toString());
    descriptionController =
        TextEditingController(text: widget.transaction['description']);
    selectedCategory = widget.transaction['category'];
  }

  // Function to update the transaction in the database
  void _updateTransaction() async {
    double amount = double.tryParse(amountController.text) ?? 0;
    String description = descriptionController.text;

    if (amount > 0 && description.isNotEmpty) {
      await dbHelper.updateTransaction(
        widget.transaction['id'], // Transaction ID
        amount,
        description,
        selectedCategory,
      );

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transaction updated successfully')));

      // Return true to indicate data was updated
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter valid data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit Transaction",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.03, // Dynamic font size
                  ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField("Amount", TextInputType.number, amountController),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField(
                "Description", TextInputType.text, descriptionController),
            SizedBox(height: screenHeight * 0.02),
            _buildCategoryDropdown(screenHeight),
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: ElevatedButton(
                onPressed: _updateTransaction,
                child: Text("Update Transaction"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenHeight * 0.1),
                  textStyle: TextStyle(fontSize: screenHeight * 0.02),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Button styling
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String hint, TextInputType type, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }

  Widget _buildCategoryDropdown(double screenHeight) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
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
