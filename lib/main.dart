import 'package:flutter/material.dart';
import 'package:hello_world/pages/form_register.dart';
import 'package:hello_world/pages/page_gambar1.dart';
import 'package:hello_world/pages/page_gambar2.dart';
import 'package:hello_world/pages/page_home_movie.dart';
import 'package:hello_world/pages/page_list_berita.dart';
import 'package:hello_world/pages/page_listview.dart';
import 'package:hello_world/pages/page_login.dart';
import 'package:hello_world/pages/page_maps.dart';
import 'package:hello_world/pages/page_movie_grid.dart';
import 'package:hello_world/pages/page_photos_json.dart';
import 'package:hello_world/pages/page_register.dart';
import 'package:hello_world/pages/page_row_column.dart';
import 'package:hello_world/pages/page_search_listview.dart';
import 'package:hello_world/pages/page_simple_form.dart';
import 'package:hello_world/pages/page_start.dart';
import 'package:hello_world/pages/page_users_json.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PageLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PageUtama extends StatelessWidget {
  const PageUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MI 2 A PNP",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),

      drawer: SizedBox(
        width: 250,
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Arzhie Z"),
                accountEmail: Text("arzhiez12@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  radius: 55,
                  child: Icon(Icons.person, color: Colors.lightBlue, size: 65),
                ),
              ),
              ListTile(
                title: Text("Wonhee"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageGambar1()),
                  );
                },
              ),
              ListTile(
                title: Text("Rumah Gadang"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageGambar2()),
                  );
                },
              ),
              ListTile(
                title: Text("Form Register"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormRegister()),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: Container(
          width: double.infinity, //lebih flex
          height: double.infinity,
          margin: EdgeInsets.all(20), //atas kanan kiri bawah
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(10), //bikin cekungan
          ),
          child: Column(
            children: [
              Text(
                'Selamat Datang di Apps Pertama MI 2A by Arzhie Z',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: Colors.orange,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageRowColumn()),
                  );
                },
                child: Text('Page Row'),
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageColumn()),
                  );
                },
                child: Text('Page Column'),
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageListview()),
                  );
                },
                child: Text('Page List View'),
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: Colors.brown,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageStart()),
                  );
                },
                child: Text('Page Stack'),
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageSimpleForm()),
                  );
                },
                child: Text('Page Simple Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
