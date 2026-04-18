import 'dart:convert';
import 'package:hello_world/models/model_photos.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String urlPhotos = "https://jsonplaceholder.typicode.com/photos";

  static Future<List<ModelPhotos>> fetchDataPhotos() async {
    final response = await http.get(Uri.parse(urlPhotos));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.take(50).map((e) => ModelPhotos.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data");
    }
  }
}
