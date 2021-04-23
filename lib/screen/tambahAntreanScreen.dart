import 'package:flutter/material.dart';

class TambahAntreanScreen extends StatefulWidget {
  @override
  _TambahAntreanScreenState createState() => _TambahAntreanScreenState();
}

class _TambahAntreanScreenState extends State<TambahAntreanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.local_hospital),
        title: Text("Tambah Antrean"),
      ),
      body: Container(
        color: Colors.teal[50],
      ),
    );
  }
}
