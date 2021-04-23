import 'package:flutter/material.dart';
import 'package:web_antrean_babatan/screen/akunPerawatScreen.dart';
import 'package:web_antrean_babatan/screen/antreanScreen.dart';
import 'package:web_antrean_babatan/screen/loginScreen.dart';
import 'package:web_antrean_babatan/screen/poliklinikScreen.dart';
import 'package:web_antrean_babatan/screen/riwayatScreen.dart';
import 'package:web_antrean_babatan/screen/tambahAntreanScreen.dart';

import 'antreanSementaraScreen.dart';
import 'dashboardScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentPage = 0;
  final List page = [
    DashboardScreen(),
    AntreanScreen(),
    AntreanSementaraScreen(),
    TambahAntreanScreen(),
    PoliklinikScreen(),
    RiwayatScreen(),
    AkunPerawatScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'asset/LogoPuskesmas.png',
                            width: 64,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Center(
                                child: Text('Selamat Datang',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal)),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Text('Puskesmas Babatan',
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.teal)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    listMenu('Dashboard', Icon(Icons.dashboard), () {
                      setState(() {
                        currentPage = 0;
                      });
                    }),
                    listMenu('Antrean', Icon(Icons.people), () {
                      setState(() {
                        currentPage = 1;
                      });
                    }),
                    listMenu('Antrean Sementara', Icon(Icons.people), () {
                      setState(() {
                        currentPage = 2;
                      });
                    }),
                    listMenu('Tambah Antrean', Icon(Icons.person_add), () {
                      setState(() {
                        currentPage = 3;
                      });
                    }),
                    listMenu('Poliklinik', Icon(Icons.local_hospital), () {
                      setState(() {
                        currentPage = 4;
                      });
                    }),
                    listMenu('Riwayat Kunjungan', Icon(Icons.history), () {
                      setState(() {
                        currentPage = 5;
                      });
                    }),
                    listMenu('Akun Perawat', Icon(Icons.switch_account), () {
                      setState(() {
                        currentPage = 6;
                      });
                    }),
                    listMenu('Logout', Icon(Icons.logout), () {
                      _showMaterialDialog();
                    }),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: page[currentPage],
          )
        ],
      ),
    );
  }

  Card listMenu(String title, Icon icon, Function func) {
    return Card(
      child: InkWell(
        onTap: func,
        child: ListTile(
          trailing: Icon(Icons.navigate_next),
          leading: icon,
          title: Text(
            title,
          ),
        ),
      ),
    );
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Keluar"),
              content: Text("Anda yakin keluar dari aplikasi?"),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text(
                    'Ya',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text(
                    'Tidak',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
