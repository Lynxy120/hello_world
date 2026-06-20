import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../services/api_service.dart';

class PageInsertBerita extends StatefulWidget {
  const PageInsertBerita({super.key});

  @override
  State<PageInsertBerita> createState() => _PageInsertBeritaState();
}

class _PageInsertBeritaState extends State<PageInsertBerita> {
  TextEditingController judulController = TextEditingController();
  TextEditingController isiController = TextEditingController();

  File? _fileGambar;
  final _imgPicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  //fungsi mengambil gambar ImagePicker
  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? _ambilGambar = await _imgPicker.pickImage(source: source);
      if (_ambilGambar != null) {
        setState(() {
          _fileGambar = File(_ambilGambar.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //fungsi untuk pilihan gambar
  void _pilihGambar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext contex) {
        return AlertDialog(
          title: Text("Pilih Gambar"),
          content: Text("Plih Sumber Gambar"),
          actions: [
            ElevatedButton(
              onPressed: () {
                _getImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: Text("Galeri"),
            ),
            ElevatedButton(
              onPressed: () {
                _getImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: Text("Camera"),
            ),
          ],
        );
      },
    );
  }

  String _message = "";
  bool _isloading = false;

  Future<bool> insertBerita() async {
    try {
      final url = Uri.parse(ApiService.urlPostBerita);

      var request = http.MultipartRequest("POST", url);

      request.fields['judul'] = judulController.text;
      request.fields['isi_berita'] = isiController.text;

      request.files.add(
        await http.MultipartFile.fromPath('gambar', _fileGambar!.path),
      );

      final response = await request.send();
      final res = await http.Response.fromStream(response);

      final data = jsonDecode(res.body);

      _message = data['message'];

      return data['is_success'] == true;
    } catch (e) {
      _message = "Error : $e";
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Berita"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox.fromSize(size: Size.fromHeight(15)),
                TextFormField(
                  controller: judulController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.wrap_text, color: Colors.black),
                    labelText: "Judul Article",
                    filled: true,
                    fillColor: Colors.lightBlueAccent.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "Judul tidak boleh kosng" : null;
                  },
                ),
                SizedBox.fromSize(size: Size.fromHeight(15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _pilihGambar(context);
                  },
                  child: Text("Pilih Gambar"),
                ),
                SizedBox.fromSize(size: Size.fromHeight(10)),
                _fileGambar != null
                    ? Image.file(_fileGambar!, width: 200, height: 200)
                    : Text("Gambar belum dipilih"),
                SizedBox.fromSize(size: Size.fromHeight(15)),
                TextFormField(
                  controller: isiController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Isi Berita",
                    filled: true,
                    fillColor: Colors.lightBlueAccent.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "Isi tidak boleh kosng" : null;
                  },
                ),
                SizedBox.fromSize(size: Size.fromHeight(15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.purple.shade200,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_fileGambar == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Gambar tidak boleh kosong"),
                          ),
                        );
                        return;
                      }

                      final berhasil = await insertBerita();

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(_message)));

                      if (berhasil && context.mounted) {
                        Navigator.pop(context, true);
                      }
                    }
                  },
                  child: _isloading
                      ? CircularProgressIndicator()
                      : Text("Simpan Berita"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
