import 'package:flutter/material.dart';
import 'package:web_antrean_babatan/screen/login.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Website Antrian Babatan"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage('PATH_GAMBAR'))),
                child: Stack(children: <Widget>[
                  Positioned(
                      bottom: 12.0,
                      left: 16.0,
                      child: Text("Administrator",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500))),
                ])),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.home),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Beranda"),
                  )
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.people),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Riwayat Kunjungan Antrean"),
                  )
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.local_hospital),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Kelola Poliklinik"),
                  )
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.access_time_rounded),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Buka Tutup Portal Pendaftaran"),
                  )
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.person_add_alt_1_rounded),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Akun Perawat"),
                  )
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Web Antrean Babatan Ver 1.0.0'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Selamat datang di Dashboard Pengelolaan Antrian',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                    "Ini adalah demo aplikasi web yang dibuat menggunakan Flutter."),
                SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
