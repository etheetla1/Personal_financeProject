import 'package:flutter/material.dart';

class SavingsGoalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Savings Goals")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Goal Amount"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Goal Name"),
            ),
            ElevatedButton(
              onPressed: () {
                // Save goal in DB
              },
              child: Text("Set Savings Goal"),
            ),
          ],
        ),
      ),
    );
  }
}
