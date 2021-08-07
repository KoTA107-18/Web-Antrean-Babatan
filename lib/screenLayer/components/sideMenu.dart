import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_antrean_babatan/blocLayer/navbar/navbar_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/session/sharedPref.dart';
import 'package:web_antrean_babatan/utils/constants/animations.dart';
import 'package:web_antrean_babatan/utils/constants/colors.dart';
import '../loginScreen.dart';

class SideMenu extends StatefulWidget {
  final NavbarBloc navbarBloc;

  const SideMenu({Key key, this.navbarBloc}) : super(key: key);
  @override
  _SideMenuState createState() => _SideMenuState(navbarBloc);
}

class _SideMenuState extends State<SideMenu> {
  final NavbarBloc _navbarBloc;

  _SideMenuState(this._navbarBloc);

  @override
  void initState() {
    _navbarBloc.add(NavbarEventGetRole());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColors.bgSideMenu,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Image.asset(
                      'asset/LogoPuskesmas.png',
                      width: 64,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Puskesmas Babatan',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: AppColors.iconSideMenu.withOpacity(0.3),
              height: 0,
              thickness: 1,
            ),
            Expanded(
              child: SafeArea(
                child: BlocBuilder<NavbarBloc, NavbarState>(
                  builder: (context, state) {
                    if (state is NavbarStateSuccessGetRole) {
                      return Material(
                        color: AppColors.bgSideMenu,
                        child:
                            (state.isAdmin) ? navbarAdmin() : navbarPerawat(),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView navbarAdmin() {
    return ListView(
      padding: EdgeInsets.only(bottom: 7),
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: AppColors.black.withOpacity(0.05),
          child: ListTile(
            horizontalTitleGap: 0.0,
            title: Text(
              "Admin",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSideMenu,
                fontSize: 25,
              ),
            ),
          ),
        ),
        Divider(
          color: AppColors.iconSideMenu.withOpacity(0.3),
          height: 0,
          thickness: 1,
        ),
        ListMenu(
          title: 'Dashboard',
          icon: Icons.dashboard,
          func: () async {
            _navbarBloc.add(NavbarEventLoadDashboard());
          },
        ),
        ListMenu(
          title: 'Antrean',
          icon: Icons.people,
          func: () async {
            _navbarBloc.add(NavbarEventLoadAntrean());
          },
        ),
        ListMenu(
          title: 'Antrean Sementara',
          icon: Icons.people,
          func: () {
            _navbarBloc.add(NavbarEventLoadAntreanSementara());
          },
        ),
        ListMenu(
          title: 'Tambah Antrean',
          icon: Icons.person_add,
          func: () {
            _navbarBloc.add(NavbarEventLoadTambahAntrean());
          },
        ),
        ListMenu(
          title: 'Poliklinik',
          icon: Icons.local_hospital,
          func: () {
            _navbarBloc.add(NavbarEventLoadPoliklinik());
          },
        ),
        ListMenu(
          title: 'Riwayat Kunjungan',
          icon: Icons.history,
          func: () {
            _navbarBloc.add(NavbarEventLoadRiwayat());
          },
        ),
        ListMenu(
          title: 'Akun Perawat',
          icon: Icons.switch_account,
          func: () {
            _navbarBloc.add(NavbarEventLoadAkunPerawat());
          },
        ),
        ListMenu(
          title: 'Logout',
          icon: Icons.logout,
          func: () {
            _showMaterialDialog(context);
          },
        ),
      ],
    );
  }

  ListView navbarPerawat() {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: AppColors.black.withOpacity(0.05),
          child: ListTile(
            horizontalTitleGap: 0.0,
            title: Text(
              "Perawat",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSideMenu,
                fontSize: 25,
              ),
            ),
          ),
        ),
        Divider(
          color: AppColors.iconSideMenu.withOpacity(0.3),
          height: 0,
          thickness: 1,
        ),
        ListMenu(
          title: 'Dashboard',
          icon: Icons.dashboard,
          func: () {
            _navbarBloc.add(NavbarEventLoadDashboard());
          },
        ),
        ListMenu(
          title: 'Antrean',
          icon: Icons.people,
          func: () {
            _navbarBloc.add(NavbarEventLoadAntrean());
          },
        ),
        ListMenu(
          title: 'Antrean Sementara',
          icon: Icons.people,
          func: () {
            _navbarBloc.add(NavbarEventLoadAntreanSementara());
          },
        ),
        ListMenu(
          title: 'Antrean Selesai',
          icon: Icons.people,
          func: () {
            _navbarBloc.add(NavbarEventLoadAntreanSelesai());
          },
        ),
        ListMenu(
          title: 'Akun',
          icon: Icons.people,
          func: () {
            _navbarBloc.add(NavbarEventLoadAkun());
          },
        ),
        ListMenu(
          title: 'Logout',
          icon: Icons.logout,
          func: () {
            _showMaterialDialog(context);
          },
        ),
      ],
    );
  }

  _showMaterialDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 600),
      transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
        return Animations.fromTop(_animation, _secondaryAnimation, _child);
      },
      pageBuilder: (_animation, _secondaryAnimation, _child) => AlertDialog(
        title: Text("Keluar"),
        content: Text("Anda yakin keluar dari aplikasi?"),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16.0, left: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ya',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    SharedPref.deleteSharedPref().then((value) {
                      Fluttertoast.showToast(
                          gravity: ToastGravity.CENTER,
                          backgroundColor: AppColors.colorMap[800],
                          msg: "Logout berhasil!",
                          toastLength: Toast.LENGTH_SHORT);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.0, right: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tidak',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ListMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function func;

  const ListMenu({Key key, this.title, this.icon, this.func});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        minVerticalPadding: 5,
        onTap: func,
        horizontalTitleGap: 0.0,
        hoverColor: AppColors.black.withOpacity(0.15),
        selectedTileColor: AppColors.black.withOpacity(0.15),
        trailing: Icon(
          Icons.navigate_next,
          color: AppColors.iconSideMenu,
        ),
        leading: Icon(
          icon,
          color: AppColors.iconSideMenu,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.textSideMenu,
          ),
        ),
      ),
    );
  }
}
