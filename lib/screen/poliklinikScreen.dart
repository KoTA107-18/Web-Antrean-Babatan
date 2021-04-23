import 'package:flutter/material.dart';

class PoliklinikScreen extends StatefulWidget {
  @override
  _PoliklinikScreenState createState() => _PoliklinikScreenState();
}

class _PoliklinikScreenState extends State<PoliklinikScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.local_hospital),
        title: Text("Daftar Poliklinik"),
      ),
      body: Container(
        color: Colors.teal[50],
      ),
    );
  }
}
