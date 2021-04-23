import 'package:flutter/material.dart';

class PoliklinikScreen extends StatefulWidget {
  @override
  _PoliklinikScreenState createState() => _PoliklinikScreenState();
}

class _PoliklinikScreenState extends State<PoliklinikScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: Icon(Icons.local_hospital),
        title: Text("Daftar Poliklinik"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(children: <Widget>[
          DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(
                  label: Text('Nama Poliklinik',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Waktu Buka',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Deskripsi Poliklinik',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Aksi',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Poliklinik Ibu Anak')),
                DataCell(Text('Senin - Jumat')),
                DataCell(Text('Melayani ...')),
                DataCell(Row(
                  children: [Icon(Icons.edit), Icon(Icons.delete)],
                )),
              ]),
            ],
          ),
        ]),
      ),
    );
  }
}
