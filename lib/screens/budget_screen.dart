import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Budget")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Budget Amount"),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                // Save or update budget in DB
              },
              child: Text("Set Budget"),
            ),
          ],
        ),
      ),
    );
  }
}
