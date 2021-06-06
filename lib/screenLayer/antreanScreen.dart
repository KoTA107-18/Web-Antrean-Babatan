import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_antrean_babatan/blocLayer/antrean/antrean_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwalPasien.dart';

class AntreanScreen extends StatefulWidget {
  @override
  _AntreanScreenState createState() => _AntreanScreenState();
}

class _AntreanScreenState extends State<AntreanScreen> {
  AntreanBloc _antreanBloc = AntreanBloc();
  int nomor;

  @override
  void initState() {
    _antreanBloc.add(EventAntreanGetPoli());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _antreanBloc,
      child: BlocBuilder<AntreanBloc, AntreanState>(
        bloc: _antreanBloc,
        builder: (context, state) {
          if (state is StateAntreanGetPoliSuccess) {
            return DefaultTabController(
                length: state.daftarPoli.length,
                child: Scaffold(
                    appBar: AppBar(
                      leading: Icon(Icons.people),
                      title: Text("Daftar Antrean"),
                      bottom: TabBar(
                        isScrollable: true,
                        tabs: List<Widget>.generate(state.daftarPoli.length,
                            (int index) {
                          return Tab(text: state.daftarPoli[index].namaPoli);
                        }),
                      ),
                    ),
                    body: TabBarView(
                      children: List<Widget>.generate(state.daftarPoli.length,
                          (int index) {
                        return FutureBuilder(
                            future: RequestApi.getAntreanWithId(
                                state.daftarPoli[index].idPoli.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                nomor = 0;
                                List<JadwalPasien> daftarAntrean = [];
                                var resultSnapshot = snapshot.data as List;
                                daftarAntrean = resultSnapshot
                                    .map(
                                        (aJson) => JadwalPasien.fromJson(aJson))
                                    .toList();
                                return Container(
                                  color: Colors.teal[50],
                                  padding: EdgeInsets.all(20.0),
                                  child: ListView(children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.teal[300],
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x29000000),
                                            offset: Offset(0, 3),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                      child: DataTable(
                                        showBottomBorder: true,
                                        columns: [
                                          DataColumn(
                                              label: Text('No',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                          DataColumn(
                                              label: Text('Nama',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                          DataColumn(
                                              label: Text('Tanggal Lahir',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                          DataColumn(
                                              label: Text('Kepala Keluarga',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                          DataColumn(
                                              label: Text('Jenis',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                          DataColumn(
                                              label: Text('Aksi',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ],
                                        rows: [
                                          for (var i in daftarAntrean)
                                            DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  return Colors.white;
                                                }),
                                                cells: [
                                                  DataCell(Text(
                                                      (nomor += 1).toString())),
                                                  DataCell(Text(i.namaLengkap)),
                                                  DataCell(Text(i.tglLahir)),
                                                  DataCell(
                                                      Text(i.kepalaKeluarga)),
                                                  DataCell(Text(
                                                      (i.tipeBooking == 1)
                                                          ? "Booking"
                                                          : "Umum")),
                                                  DataCell(Row(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(Icons
                                                              .access_time_sharp),
                                                          onPressed: () {}),
                                                      IconButton(
                                                          icon:
                                                              Icon(Icons.edit),
                                                          onPressed: () {})
                                                    ],
                                                  )),
                                                ])
                                        ],
                                      ),
                                    ),
                                  ]),
                                );
                              } else if (snapshot.data == null &&
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                return Container(
                                  child: Center(
                                    child: Text("Data Kosong"),
                                  ),
                                );
                              } else {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            });
                      }),
                    )));
          }
          if (state is StateAntreanGetPoliFailed) {
            return failedScreen(state.messageFailed);
          } else {
            return loadingScreen();
          }
        },
      ),
    );
  }

  Scaffold failedScreen(String messageFailed) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.people),
          title: Text("Daftar Antrean"),
        ),
        body: Container(
          color: Colors.teal[50],
          child: Center(
            child: Text(messageFailed),
          ),
        ));
  }

  Scaffold loadingScreen() {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.people),
          title: Text("Daftar Antrean"),
        ),
        body: Container(
          color: Colors.teal[50],
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
