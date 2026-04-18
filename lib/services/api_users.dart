import 'dart:convert';
import 'package:hello_world/models/model_users.dart';
import 'package:http/http.dart' as http;

class ApiUsers {
  Future<List<ModelUsers>> fetchDataUsers() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      return modelUsersFromJson(response.body);
    } else {
      throw Exception("Failed load users");
    }
  }
}
