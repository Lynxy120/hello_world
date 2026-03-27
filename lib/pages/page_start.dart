import 'package:flutter/material.dart';

class PageStart extends StatelessWidget {
  const PageStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Stack'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Stack(
        children: [
          Container(width: double.infinity, height: 200, color: Colors.red),
          Container(width: 150, height: 200, color: Colors.green),
          Container(width: 100, height: 200, color: Colors.blue),
        ],
      ),
    );
  }
}
