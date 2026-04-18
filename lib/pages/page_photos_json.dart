import 'package:flutter/material.dart';
import 'package:hello_world/pages/page_detail_photos.dart';

import '../models/model_photos.dart';
import '../services/api_service.dart';

class PagePhotosJson extends StatefulWidget {
  const PagePhotosJson({super.key});

  @override
  State<PagePhotosJson> createState() => _PagePhotosJsonState();
}

class _PagePhotosJsonState extends State<PagePhotosJson> {
  late Future<List<ModelPhotos>> futurePhotos;
  List<ModelPhotos> allPhotos = [];
  List<ModelPhotos> filteredPhotos = [];

  @override
  void initState() {
    super.initState();
    futurePhotos = ApiService.fetchDataPhotos(); //ambil service

    futurePhotos.then((data) {
      setState(() {
        allPhotos = data;
        filteredPhotos = data;
      });
    });
  }

  void searchPhotos(String query) {
    final result = allPhotos.where((photo) {
      return photo.id.toString().contains(query);
    }).toList();

    setState(() {
      filteredPhotos = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos Json"),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Terjadi Kesalahan"));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Data kosong"));
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: searchPhotos,
                  decoration: InputDecoration(
                    hintText: "Search by photo ID...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: filteredPhotos.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4,
                  ),

                  itemBuilder: (context, index) {
                    final photo = filteredPhotos[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PageDetailPhoto(photo: photo!),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.network(
                                  photo!.randomImage,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                photo.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
