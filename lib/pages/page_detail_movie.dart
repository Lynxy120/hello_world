import 'package:flutter/material.dart';

import '../models/movie.dart';

class PageDetailMovie extends StatelessWidget {
  const PageDetailMovie({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.lightBlue,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(movie.image),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(movie.desc, style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
