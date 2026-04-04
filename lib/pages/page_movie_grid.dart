import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/pages/page_detail_movie.dart';

import '../models/movie.dart';

class PageMovieGrid extends StatefulWidget {
  const PageMovieGrid({super.key});

  @override
  State<PageMovieGrid> createState() => _PageMovieGridState();
}

class _PageMovieGridState extends State<PageMovieGrid> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    //proses do in background sebelum view di panggil
    loadMovies();
  }

  Future<void> loadMovies() async {
    final String response = await rootBundle.loadString(
      "lib/data/movies.json",
    ); //pastikan sudah masuk ke pubspec.yaml
    final data = json.decode(response);

    setState(() {
      movies = List<Movie>.from(data.map((item) => Movie.fromJson(item)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie App"),
        backgroundColor: Colors.lightBlue,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(12),
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PageDetailMovie(movie: movie),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(movie.image, fit: BoxFit.cover),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.lightBlue.withOpacity(0.6),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(10, 10, 10, 6),
                  child: Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
