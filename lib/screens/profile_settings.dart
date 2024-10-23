import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile & Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Dark Mode"),
              value: true, // get from DB or shared preferences
              onChanged: (bool value) {
                // Save setting to DB
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Export Data Functionality
              },
              child: Text("Export Data"),
            )
          ],
        ),
      ),
    );
  }
}
