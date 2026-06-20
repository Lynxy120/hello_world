import 'dart:convert';
import 'package:hello_world/models/model_photos.dart';
import 'package:http/http.dart' as http;

import '../models/model_berita.dart';

class ApiService {
  static const String urlPhotos = "https://jsonplaceholder.typicode.com/photos";
  static const String baseUrl = "http://10.77.243.1:3000";

  static const String urlGambarBerita = "${baseUrl}/images";
  static const String urlGetBerita = "${baseUrl}/getBerita.php";
  static const String urlRegister = "${baseUrl}/register.php";
  static const String urlLogin = "${baseUrl}/login.php";
  static const String urlPostBerita = "${baseUrl}/postBerita.php";

  static Future<List<ModelPhotos>> fetchDataPhotos() async {
    final response = await http.get(Uri.parse(urlPhotos));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.take(50).map((e) => ModelPhotos.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  static Future<List<Datum>> getDataBerita() async {
    final response = await http.get(Uri.parse(urlGetBerita));

    if (response.statusCode == 200) {
      final model = modelBeritaFromJson(response.body);
      return model.data;
    } else {
      throw Exception("Gagal mengambil data");
    }
  }
}
