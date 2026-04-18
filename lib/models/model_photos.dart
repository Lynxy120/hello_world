// To parse this JSON data, do
//
//     final modelPhotos = modelPhotosFromJson(jsonString);

import 'dart:convert';

List<ModelPhotos> modelPhotosFromJson(String str) => List<ModelPhotos>.from(
  json.decode(str).map((x) => ModelPhotos.fromJson(x)),
);

String modelPhotosToJson(List<ModelPhotos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPhotos {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  ModelPhotos({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory ModelPhotos.fromJson(Map<String, dynamic> json) => ModelPhotos(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };

  String get randomImage {
    return "https://picsum.photos/200?random=$id";
  }
}
