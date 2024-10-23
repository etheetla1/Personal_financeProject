import 'package:flutter/material.dart';

class IncomeExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Income & Expenses"),
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
            _buildTextField(context, "Amount", TextInputType.number),
            SizedBox(height: 10),
            _buildTextField(context, "Description", TextInputType.text),
            SizedBox(height: 10),
            _buildCategoryDropdown(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
              child: Text("Add Transaction"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18),
                backgroundColor: Theme.of(context)
                    .primaryColor, // Use backgroundColor instead of primary
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TextField builder for consistency
  Widget _buildTextField(
      BuildContext context, String hintText, TextInputType type) {
    return TextField(
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

  // Category dropdown
  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
      items: <String>['Groceries', 'Rent', 'Utilities'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {},
      hint: Text("Choose Category"),
    );
  }
}
