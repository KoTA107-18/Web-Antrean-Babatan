import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_antrean_babatan/blocLayer/navbar/navbar_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/sharedPref.dart';
import 'package:web_antrean_babatan/utils/color.dart';
import 'akunPerawatScreen.dart';
import 'antreanScreen.dart';
import 'antreanSementaraScreen.dart';
import 'dashboardScreen.dart';
import 'loginScreen.dart';
import 'poliklinikScreen.dart';
import 'riwayatScreen.dart';
import 'tambahAntreanScreen.dart';

class MainScreen extends StatelessWidget {
  final NavbarBloc navbarBloc = NavbarBloc(1);
  final List page = [
    DashboardScreen(),
    AntreanScreen(),
    AntreanSementaraScreen(),
    TambahAntreanScreen(),
    PoliklinikScreen(),
    RiwayatScreen(),
    AkunPerawatScreen()
  ];

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

  _showMaterialDialog(BuildContext context) {
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
                    SharedPref.deleteSharedPref().then((value) {
                      Fluttertoast.showToast(
                          gravity: ToastGravity.CENTER,
                          backgroundColor: ColorTheme.greenDark,
                          msg: "Logout berhasil!",
                          toastLength: Toast.LENGTH_SHORT);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    });
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => navbarBloc,
      child: Scaffold(
        body: BlocBuilder<NavbarBloc, int>(
          builder: (context, index) {
            return Row(
              children: [
                Container(
                  width: 280.0,
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
                                            fontSize: 14.0,
                                            color: Colors.teal)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        listMenu('Dashboard', Icon(Icons.dashboard), () {
                          navbarBloc.add(NavbarEvent.tapDashboard);
                        }),
                        listMenu('Antrean', Icon(Icons.people), () {
                          navbarBloc.add(NavbarEvent.tapAntrean);
                        }),
                        listMenu('Antrean Sementara', Icon(Icons.people), () {
                          navbarBloc.add(NavbarEvent.tapAntreanSementara);
                        }),
                        listMenu('Tambah Antrean', Icon(Icons.person_add), () {
                          navbarBloc.add(NavbarEvent.tapTambahAntrean);
                        }),
                        listMenu('Poliklinik', Icon(Icons.local_hospital), () {
                          navbarBloc.add(NavbarEvent.tapPoliklinik);
                        }),
                        listMenu('Riwayat Kunjungan', Icon(Icons.history), () {
                          navbarBloc.add(NavbarEvent.tapRiwayatKunjungan);
                        }),
                        listMenu('Akun Perawat', Icon(Icons.switch_account),
                            () {
                          navbarBloc.add(NavbarEvent.tapAkunPerawat);
                        }),
                        listMenu('Antrean Utama Perawat', Icon(Icons.person),
                                () {
                          navbarBloc.add(NavbarEvent.tapAntrean);
                        }),
                        listMenu('Antrean Sementara Perawat', Icon(Icons.switch_account),
                                () {
                          navbarBloc.add(NavbarEvent.tapAntreanSementara);
                        }),
                        listMenu('Selesai Dilayani', Icon(Icons.switch_account),
                                () {
                          navbarBloc.add(NavbarEvent.tapAkunPerawat);
                        }),
                        listMenu('Logout', Icon(Icons.logout), () {
                          _showMaterialDialog(context);
                        }),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: page.elementAt(index),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
