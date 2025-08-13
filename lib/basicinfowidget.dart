

import 'package:flutter/material.dart';

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Info'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.ad_units_outlined),label: "Test")
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 20),
            ),
            // Add more widgets here later
          ],
        ),
      ),
    );
  }
}
