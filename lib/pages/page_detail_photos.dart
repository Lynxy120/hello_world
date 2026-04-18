import 'package:flutter/material.dart';
import '../models/model_photos.dart';

class PageDetailPhoto extends StatelessWidget {
  final ModelPhotos photo;

  const PageDetailPhoto({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Photo"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Image.network(
            photo.randomImage,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              photo.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}