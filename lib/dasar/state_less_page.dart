import 'package:flutter/material.dart';

class StateLessPage extends StatelessWidget {
  const StateLessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman StateLess'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(child: Text("Belajar Flutter")),
    );
  }
}
