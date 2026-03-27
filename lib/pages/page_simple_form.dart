import 'package:flutter/material.dart';

import '../main.dart';

class PageSimpleForm extends StatefulWidget {
  const PageSimpleForm({super.key});

  @override
  State<PageSimpleForm> createState() => _PageSimpleFormState();
}

class _PageSimpleFormState extends State<PageSimpleForm> {

  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Simple Form'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Card(
            child: Container(
              width: double.infinity,
              height: 100,
              color: Colors.lightBlue,
              child: Text("Form Simple Data"),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: txtUsername,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: txtPassword,
              obscureText: true, //biar bulat" / ga keliatan pw nya
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                String nUsername = txtUsername.text.toString();
                String nPassword = txtPassword.text.toString();

                if(nUsername == 'admin' && nPassword == 'admin'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageUtama()),
                  );
                }
                else if(nUsername != 'admin' || nPassword != 'admin'){
                  print("Username atau Password salah");
                }

                print("Username anda adalah :"+nUsername + " dan password anda adalah : ${nPassword}");
                print("Anda klik button login");
              },
              child: Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}


/*class PageSimpleForm extends StatelessWidget {
  const PageSimpleForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Simple Form'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Card(
            child: Container(
              width: double.infinity,
              height: 100,
              color: Colors.lightBlue,
              child: Text("Form Simple Data"),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true, //biar bulat" / ga keliatan pw nya
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                print("Anda klik button login");
              },
              child: Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}*/
