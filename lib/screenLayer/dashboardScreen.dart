import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_antrean_babatan/blocLayer/dashboard/dashboard_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/model/infoPoliklinik.dart';
import 'package:web_antrean_babatan/utils/constants/colors.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardBloc dashboardBloc = DashboardBloc();
  var sizeWidth = 0;

  String dateSlug = ""
      "${DateTime.now().year.toString()}/"
      "${DateTime.now().month.toString().padLeft(2, '0')}/"
      "${DateTime.now().day.toString().padLeft(2, '0')}";

  @override
  void initState() {
    dashboardBloc.add(EventDashboardGetPoli());
    super.initState();
  }

  cardTextStyle(double fontSize, FontWeight fontWeight) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: AppColors.colorMap[900]);
  }

  cardPoli(List<InfoPoliklinik> daftarPoli) {
    return GridView.builder(
      itemCount: daftarPoli.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (sizeWidth > 1440)
            ? 3
            : (sizeWidth > 768)
                ? 2
                : 1,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: (daftarPoli[index].statusPoli == 1.toString())
                ? AppColors.white
                : AppColors.colorMap[900].withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.15),
                blurRadius: 6,
                offset: Offset(0.5, 0.5),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Poliklinik :",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 12.0),
                child: Text(
                  daftarPoli[index].namaPoli,
                  style: cardTextStyle(20, FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Antrean",
                      style: cardTextStyle(18, FontWeight.w500),
                    ),
                    (daftarPoli[index].totalAntrean.length == 0)
                        ? Text(
                            "0",
                            style: cardTextStyle(18, FontWeight.w500),
                          )
                        : Text(
                            daftarPoli[index].totalAntrean[0].result,
                            style: cardTextStyle(18, FontWeight.w500),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Antrean Sementara",
                      style: cardTextStyle(18, FontWeight.w500),
                    ),
                    (daftarPoli[index].antreanSementara.length == 0)
                        ? Text(
                            "0",
                            style: cardTextStyle(18, FontWeight.w500),
                          )
                        : Text(
                            daftarPoli[index].antreanSementara[0].result,
                            style: cardTextStyle(18, FontWeight.w500),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nomor Antrean Saat Ini",
                      style: cardTextStyle(18, FontWeight.w500),
                    ),
                    (daftarPoli[index].nomorAntrean.length == 0)
                        ? Text(
                            "0",
                            style: cardTextStyle(18, FontWeight.w500),
                          )
                        : Text(
                            daftarPoli[index].nomorAntrean[0].result,
                            style: cardTextStyle(18, FontWeight.w500),
                          ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _portalDialog(BuildContext context, bool isOpen) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: (isOpen) ? Text("Buka Portal") : Text("Tutup Portal"),
              content: (isOpen)
                  ? Text("Anda yakin membuka portal Puskesmas yang dipilih?")
                  : Text("Anda yakin menutup portal Puskesmas yang dipilih?"),
              actions: <Widget>[
                (isOpen)
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: Text(
                          'Ya',
                          style: TextStyle(color: Colors.white),
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
                        child: Text(
                          'Ya',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          dashboardBloc.add(EventDashboardTutupPortal());
                          Navigator.pop(context);
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

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    sizeWidth = MediaQuery.of(context).size.width as int;
    print(sizeWidth.toString());
    return BlocProvider(
      create: (_) => dashboardBloc,
      child: BlocListener<DashboardBloc, DashboardState>(
        cubit: dashboardBloc,
        listener: (context, state) {
          if (state is StateDashboardSuccess) {
            Timer.periodic(Duration(milliseconds: 5000), (timer) {
              dashboardBloc.add(EventDashboardGetPoliSilent());
            });
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          cubit: dashboardBloc,
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
                                          child: Text('Portal Pendaftaran',
                                              style: TextStyle(
                                                  fontSize: 18.0,
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
                                          child: Text("Buka Portal")),
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
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(10),
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
