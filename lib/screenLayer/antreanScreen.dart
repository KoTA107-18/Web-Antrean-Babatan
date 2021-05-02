import 'package:flutter/material.dart';

class AntreanScreen extends StatefulWidget {
  @override
  _AntreanScreenState createState() => _AntreanScreenState();
}

class _AntreanScreenState extends State<AntreanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: Icon(Icons.people),
        title: Text("Daftar Antrean"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(children: <Widget>[
          DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(
                  label: Text('Antrean',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Nama Pasien',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Tanggal Lahir',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Kepala Keluarga',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Jenis',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Aksi',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
            ],
          ),
        ]),
      ),
    );
  }
}
