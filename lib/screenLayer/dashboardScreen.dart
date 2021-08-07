import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_antrean_babatan/blocLayer/dashboard/dashboard_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/model/infoPoliklinik.dart';
import 'package:web_antrean_babatan/utils/constants/animations.dart';
import 'package:web_antrean_babatan/utils/constants/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardBloc dashboardBloc = DashboardBloc();
  var sizeWidth = 0;

  @override
  void initState() {
    dashboardBloc.add(EventDashboardGetPoli());
    super.initState();
  }

  cardPoli(List<InfoPoliklinik> daftarPoli) {
    return StaggeredGridView.countBuilder(
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      crossAxisCount: (sizeWidth >= 1400)
          ? 4
          : (sizeWidth >= 1200)
              ? 3
              : (sizeWidth >= 768)
                  ? 2
                  : 1,
      itemCount: daftarPoli.length,
      itemBuilder: (context, index) => Card(
        color: (daftarPoli[index].statusPoli == 1.toString())
            ? AppColors.white
            : AppColors.white.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColors.primaryColor, width: 1.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Poliklinik',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Center(
                child: Text(
                  daftarPoli[index].namaPoli,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Antrean',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    (daftarPoli[index].totalAntrean.length == 0)
                        ? '0'
                        : daftarPoli[index].totalAntrean[0].result,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Antrean Sementara',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    (daftarPoli[index].antreanSementara.length == 0)
                        ? '0'
                        : daftarPoli[index].antreanSementara[0].result,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nomor Antrean Saat Ini',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    (daftarPoli[index].nomorAntrean.length == 0)
                        ? '0'
                        : daftarPoli[index].nomorAntrean[0].result,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _portalDialog(BuildContext context, bool isOpen) {
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 600),
      transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
        return Animations.fromTop(_animation, _secondaryAnimation, _child);
      },
      pageBuilder: (_animation, _secondaryAnimation, _child) => AlertDialog(
        title: (isOpen) ? Text("Buka Portal") : Text("Tutup Portal"),
        content: (isOpen)
            ? Text("Anda yakin membuka portal Puskesmas yang dipilih?")
            : Text("Anda yakin menutup portal Puskesmas yang dipilih?"),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 16.0, right: 16.0),
            child: (isOpen)
                ? ElevatedButton(
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
                      dashboardBloc.add(EventDashboardBukaPortal());
                      Navigator.pop(context);
                    },
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
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
                      dashboardBloc.add(EventDashboardTutupPortal());
                      Navigator.pop(context);
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
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    sizeWidth = MediaQuery.of(context).size.width as int;
    print(sizeWidth.toString());
    return BlocProvider(
      create: (_) => dashboardBloc,
      child: BlocListener<DashboardBloc, DashboardState>(
        bloc: dashboardBloc,
        listener: (context, state) {
          if (state is StateDashboardSuccess) {
            Timer.periodic(Duration(milliseconds: 5000), (timer) {
              dashboardBloc.add(EventDashboardGetPoliSilent());
            });
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          bloc: dashboardBloc,
          builder: (BuildContext context, state) {
            if (state is StateDashboardLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is StateDashboardFailed) {
              return Center(child: Text(state.messageFailed));
            } else if (state is StateDashboardSuccess) {
              return Scaffold(
                key: _scaffoldkey,
                endDrawer: (dashboardBloc.isAdmin)
                    ? Expanded(
                        child: Container(
                          width: 304.0,
                          transformAlignment: Alignment.centerRight,
                          color: Colors.white,
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'asset/LogoPuskesmas.png',
                                      width: 64,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Text(
                                            'Portal Pendaftaran',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            'Puskesmas Babatan',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: AppColors.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _portalDialog(context, true);
                                        },
                                        child: Text("Buka Portal"),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Expanded(
                                      flex: 2,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red, // background
                                            onPrimary:
                                                Colors.white, // foreground
                                          ),
                                          onPressed: () {
                                            _portalDialog(context, false);
                                          },
                                          child: Text("Tutup Portal")),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  children: [
                                    for (var i in state.daftarPoli)
                                      CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: Text(i.namaPoli),
                                        secondary:
                                            const Icon(Icons.local_hospital),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value) {
                                              i.statusPoli = 1.toString();
                                            } else {
                                              i.statusPoli = 0.toString();
                                            }
                                          });
                                        },
                                        value: (i.statusPoli == 1.toString())
                                            ? true
                                            : false,
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                body: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: cardPoli(state.daftarPoli),
                      ),
                    ),
                  ],
                ),
                floatingActionButton: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: FloatingActionButton(
                    child: Icon(Icons.more_vert),
                    backgroundColor: AppColors.bgSideMenu,
                    foregroundColor: AppColors.iconSideMenu,
                    onPressed: () {
                      _scaffoldkey.currentState.openEndDrawer();
                    },
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.miniEndTop,
              );
            } else {
              return Center(
                child: Text("Unknown"),
              );
            }
          },
        ),
      ),
    );
  }
}
