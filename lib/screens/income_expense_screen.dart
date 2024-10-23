import 'package:flutter/material.dart';

class IncomeExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Income & Expenses")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Description"),
            ),
            DropdownButton<String>(
              items: <String>['Groceries', 'Rent', 'Utilities']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
              hint: Text("Choose Category"),
            ),
            ElevatedButton(
              onPressed: () {
                // Save income/expense in DB
              },
              child: Text("Add Transaction"),
            )
          ],
        ),
      ),
    );
  }
}
