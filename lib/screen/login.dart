import 'package:flutter/material.dart';
import 'package:web_antrean_babatan/screen/dashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: TextField(
                controller: _username,
                decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)))),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: TextField(
                controller: _password,
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.vpn_key_sharp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)))),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: ElevatedButton(
                child: Text("Masuk"),
                onPressed: () {
                  if (_username.text == "admin" && _password.text == "admin") {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  }
                },
              ))
        ],
      ),
    );
  }
}
