import 'package:flutter/material.dart';

class PageListview extends StatelessWidget {
  const PageListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Page List View"),
      ),
      body: ListView(
        children: [
          Container(height: 100, color: Colors.red),
          SizedBox(height: 10), //space kalau ke bawah atau vertikal
          Container(height: 100, color: Colors.green),
          SizedBox(height: 10),
          Container(height: 100, color: Colors.blue),
          Container(height: 100, color: Colors.yellow),
          SizedBox(height: 10),
          Container(height: 100, color: Colors.black),
        ],
      ),
    );
  }
}
