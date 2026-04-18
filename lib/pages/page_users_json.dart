import 'package:flutter/material.dart';
import 'package:hello_world/models/model_users.dart';
import 'package:hello_world/pages/page_detail_users.dart';
import 'package:hello_world/services/api_users.dart';

class PageUsersJson extends StatefulWidget {
  const PageUsersJson({super.key});

  @override
  State<PageUsersJson> createState() => _PageUsersJsonState();
}

class _PageUsersJsonState extends State<PageUsersJson> {
  late Future<List<ModelUsers>> futureUsers;
  List<ModelUsers> allUsers = [];
  List<ModelUsers> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    futureUsers = ApiUsers().fetchDataUsers(); //ambil service

    futureUsers.then((data) {
      setState(() {
        allUsers = data;
        filteredUsers = data;
      });
    });
  }

  void searchUsers(String query) {
    final result = allUsers.where((user) {
      return user.id.toString().contains(query) ||
          user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.address.city.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredUsers = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Json"),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder<List<ModelUsers>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Terjadi Kesalahan"));
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: searchUsers,
                  decoration: InputDecoration(
                    hintText: "Search by ID, Name, City...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                      child: ListTile(
                        leading: CircleAvatar(child: Text(user.id.toString())),

                        title: Text(user.name),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(user.email), Text(user.address.city)],
                        ),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PageDetailUser(user: user),
                            ),
                          );
                        },
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
