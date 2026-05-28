import 'package:flutter/material.dart';
import 'package:hello_world/models/model_berita.dart';
import 'package:intl/intl.dart';

class PageDetailBerita extends StatelessWidget {
  final Datum berita;

  const PageDetailBerita({super.key, required this.berita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Berita"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Image.network(
            "http://10.44.130.1:3000/${berita.gambar}",
            webHtmlElementStrategy:
                WebHtmlElementStrategy.prefer, //agar bisa keluar gambar di web
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 12),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              berita.judul,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(
              DateFormat('dd MMM yyyy').format(berita.tgl),
              style: TextStyle(color: Colors.grey),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              berita.isiBerita,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
