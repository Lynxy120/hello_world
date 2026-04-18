import 'package:flutter/material.dart';
import '../models/model_users.dart';

class PageDetailUser extends StatelessWidget {
  final ModelUsers user;

  const PageDetailUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Detail"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              user.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text("Username: ${user.username}"),
            Text("Email: ${user.email}"),
            Text("Phone: ${user.phone}"),
            Text("Website: ${user.website}"),

            SizedBox(height: 20),

            Text(
              "Address",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Text("${user.address.street}, ${user.address.suite}"),
            Text("${user.address.city}, ${user.address.zipcode}"),

            SizedBox(height: 20),

            Text(
              "Company",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Text(user.company.name),
            Text(user.company.catchPhrase),
            Text(user.company.bs),
          ],
        ),
      ),
    );
  }
}