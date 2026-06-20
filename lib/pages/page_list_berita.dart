import 'package:flutter/material.dart';
import 'package:hello_world/helper/session_manager.dart';
import 'package:hello_world/pages/page_detail_berita.dart';
import 'package:hello_world/pages/page_insert_berita.dart';
import 'package:hello_world/pages/page_login.dart';
import 'package:hello_world/services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../models/model_berita.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  late Future<List<Datum>> futureBerita;

  List<Datum> _allBerita = [];
  List<Datum> _filteredBerita = [];

  final TextEditingController _searchCtrl = TextEditingController();

  String? username;
  String? email;
  String? id;
  String? tglDaftar;
  String? level;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBerita = ApiService.getDataBerita();
    _loadUserData();
  }

  void _loadUserData() async {
    final userData = await SessionManager.getUserSession();
    setState(() {
      username = userData['username'];
      email = userData['email'];
      id = userData['id'];
      tglDaftar = userData['tgl_daftar'];
      level = userData['level'];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchCtrl.dispose();
  }

  void _onSearchBar(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredBerita = List.from(_allBerita);
      } else {
        _filteredBerita = _allBerita.where((berita) {
          return berita.judul.toLowerCase().contains(query.toLowerCase()) ||
              berita.isiBerita.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = level == 'admin';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          username != null ? "Selamat datang, $username" : "Daftar Berita",
        ),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await SessionManager.logout();

              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const PageLogin()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: futureBerita,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (_allBerita.isEmpty) {
            _allBerita = snapshot.data!;
            _filteredBerita = List.from(_allBerita);
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: _onSearchBar,
                  decoration: InputDecoration(
                    hintText: "Cari berita...",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.lightBlue,
                    ),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchCtrl.clear();
                              _onSearchBar('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),

              if (_searchCtrl.text.isNotEmpty)
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 16, bottom: 8),
                  child: Text("${_filteredBerita.length} berita ditemukan"),
                ),
              Expanded(
                child: _filteredBerita.isEmpty
                    ? const Center(child: Text("Berita tidak ditemukan"))
                    : RefreshIndicator(
                        color: Colors.lightBlue,
                        onRefresh: () async {
                          setState(() {
                            _allBerita.clear();
                            futureBerita = ApiService.getDataBerita();
                          });
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          itemCount: _filteredBerita.length,
                          itemBuilder: (context, index) {
                            return _buildBeritaCard(
                              context,
                              _filteredBerita[index],
                              isAdmin,
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              child: const Icon(Icons.add),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PageInsertBerita(),
                  ),
                );

                if (result == true) {
                  setState(() {
                    _allBerita.clear();
                    futureBerita = ApiService.getDataBerita();
                  });
                }
              },
            )
          : null, //kalu bukan admin button ini gk muncul
    );
  }
}

Widget _buildBeritaCard(BuildContext context, Datum berita, bool isAdmin) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 3,
    margin: EdgeInsetsDirectional.only(bottom: 12),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageDetailBerita(berita: berita),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              "${ApiService.urlGambarBerita}/${berita.gambar}",
              webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Text(berita.judul, maxLines: 2),
          ),
        ],
      ),
    ),
  );
}
