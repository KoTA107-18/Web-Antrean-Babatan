import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_antrean_babatan/blocLayer/navbar/navbar_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/sharedPref.dart';
import 'package:web_antrean_babatan/utils/color.dart';
import 'loginScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NavbarBloc _navbarBloc = NavbarBloc();

  @override
  void initState() {
    _navbarBloc.add(NavbarEventGetRole());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _navbarBloc,
      child: Scaffold(
        body: Row(
          children: [
            Container(
              width: 280.0,
              color: Colors.white,
              child: SafeArea(
                child: BlocBuilder<NavbarBloc, NavbarState>(
                  builder: (context, state) {
                    if (state is NavbarStateSuccessGetRole) {
                      return (state.isAdmin) ? navbarAdmin() : navbarPerawat();
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
            BlocBuilder<NavbarBloc, NavbarState>(
              builder: (context, state) {
                if (state is NavbarStateSuccessGetRole) {
                  return Expanded(
                    child: state.page,
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  ListView navbarAdmin() {
    return ListView(
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
                        style: TextStyle(fontSize: 14.0, color: Colors.teal)),
                  ),
                ),
              ],
            )
          ],
        ),
        Card(
          color: Colors.teal[50],
          child: ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text(
              "Admin",
            ),
          ),
        ),
        listMenu('Dashboard', Icon(Icons.dashboard), () {
          _navbarBloc.add(NavbarEventLoadDashboard());
        }),
        listMenu('Antrean', Icon(Icons.people), () {
          _navbarBloc.add(NavbarEventLoadAntrean());
        }),
        listMenu('Antrean Sementara', Icon(Icons.people), () {
          _navbarBloc.add(NavbarEventLoadAntreanSementara());
        }),
        listMenu('Tambah Antrean', Icon(Icons.person_add), () {
          _navbarBloc.add(NavbarEventLoadTambahAntrean());
        }),
        listMenu('Poliklinik', Icon(Icons.local_hospital), () {
          _navbarBloc.add(NavbarEventLoadPoliklinik());
        }),
        listMenu('Riwayat Kunjungan', Icon(Icons.history), () {
          _navbarBloc.add(NavbarEventLoadRiwayat());
        }),
        listMenu('Akun Perawat', Icon(Icons.switch_account), () {
          _navbarBloc.add(NavbarEventLoadAkunPerawat());
        }),
        listMenu('Logout', Icon(Icons.logout), () {
          _showMaterialDialog(context);
        }),
      ],
    );
  }

  ListView navbarPerawat() {
    return ListView(
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
                        style: TextStyle(fontSize: 14.0, color: Colors.teal)),
                  ),
                ),
              ],
            )
          ],
        ),
        Card(
          color: Colors.teal[50],
          child: ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text(
              "Perawat",
            ),
          ),
        ),
        listMenu('Dashboard', Icon(Icons.dashboard), () {
          _navbarBloc.add(NavbarEventLoadDashboard());
        }),
        listMenu('Antrean', Icon(Icons.people), () {
          _navbarBloc.add(NavbarEventLoadAntrean());
        }),
        listMenu('Antrean Sementara', Icon(Icons.people), () {
          _navbarBloc.add(NavbarEventLoadAntreanSementara());
        }),
        listMenu('Antrean Selesai', Icon(Icons.people), () {}),
        listMenu('Akun', Icon(Icons.people), () {}),
        listMenu('Logout', Icon(Icons.logout), () {
          _showMaterialDialog(context);
        }),
      ],
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
}
