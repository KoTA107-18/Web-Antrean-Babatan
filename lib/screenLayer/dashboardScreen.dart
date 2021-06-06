import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_antrean_babatan/blocLayer/dashboard/dashboard_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardBloc dashboardBloc = DashboardBloc();
  String dateSlug = ""
      "${DateTime.now().year.toString()}/"
      "${DateTime.now().month.toString().padLeft(2, '0')}/"
      "${DateTime.now().day.toString().padLeft(2, '0')}";

  @override
  void initState() {
    dashboardBloc.add(EventDashboardGetPoli());
    super.initState();
  }

  cardPoli(List<Poliklinik> daftarPoli) {
    return GridView.builder(
      itemCount: daftarPoli.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.7),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(right: 8, top: 8, bottom: 8, left: 4),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: (daftarPoli[index].statusPoli == 1)
                ? Colors.white
                : Colors.grey[300],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 2,
                offset: Offset(0.5, 0.5),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Poliklinik :",
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 12.0),
                    child: Text(
                      daftarPoli[index].namaPoli,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Antrean",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text("NULL"),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Antrean Sementara",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text("NULL"),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nomor Antrean Saat Ini",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text("NULL"),
                      ],
                    ),
                  )
                ],
              ),
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => dashboardBloc,
        child: Scaffold(
          backgroundColor: Colors.teal[50],
          appBar: AppBar(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            actions: [
              Container(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                      child: Text(
                    dateSlug,
                    style: TextStyle(fontSize: 18.0),
                  ))),
            ],
          ),
          body: BlocBuilder<DashboardBloc, DashboardState>(
            bloc: dashboardBloc,
            builder: (BuildContext context, state) {
              if (state is StateDashboardLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is StateDashboardFailed) {
                return Center(child: Text(state.messageFailed));
              } else if (state is StateDashboardSuccess) {
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: cardPoli(state.daftarPoli),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          onPrimary: Colors.white, // foreground
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
                                            i.statusPoli = 1;
                                          } else {
                                            i.statusPoli = 0;
                                          }
                                        });
                                      },
                                      value: (i.statusPoli == 1) ? true : false,
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Text("Unknown"),
                );
              }
            },
          ),
        ));
  }
}
