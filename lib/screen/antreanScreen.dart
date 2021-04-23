import 'package:flutter/material.dart';

class AntreanScreen extends StatefulWidget {
  @override
  _AntreanScreenState createState() => _AntreanScreenState();
}

class _AntreanScreenState extends State<AntreanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.people),
        title: Text("Daftar Antrean"),
      ),
      body: Container(
        color: Colors.teal[50],
      ),
    );
  }
}
