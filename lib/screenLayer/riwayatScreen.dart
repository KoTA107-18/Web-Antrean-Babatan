import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_antrean_babatan/blocLayer/riwayatKunjungan/riwayat_kunjungan_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';

class RiwayatScreen extends StatefulWidget {
  @override
  _RiwayatScreenState createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  RiwayatKunjunganBloc _riwayatKunjunganBloc = RiwayatKunjunganBloc();

  @override
  void initState() {
    _riwayatKunjunganBloc.add(RiwayatKunjunganEventGetPoli());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _riwayatKunjunganBloc,
      child: BlocBuilder<RiwayatKunjunganBloc, RiwayatKunjunganState>(
        bloc: _riwayatKunjunganBloc,
        builder: (context, state) {
          if (state is StateRiwayatGetPoliSuccess) {
            return DefaultTabController(
                length: state.daftarPoli.length,
                child: Scaffold(
                    appBar: AppBar(
                      leading: Icon(Icons.people),
                      title: Text("Daftar Riwayat Kunjungan"),
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
                                    List<Map<String, dynamic>> daftarAntrean = [];
                                    var resultSnapshot = snapshot.data as List;
                                    daftarAntrean = resultSnapshot.map((aJson) {
                                      return {
                                        'nomor_antrean':
                                        aJson['nomor_antrean'].toString(),
                                        'username': aJson['username'],
                                        'tgl_pelayanan': aJson['tgl_pelayanan'],
                                        'tipe_booking':
                                        aJson['tipe_booking'].toString(),
                                        'jam_daftar_antrean':
                                        aJson['jam_daftar_antrean'],
                                        'status_antrean':
                                        aJson['status_antrean'].toString(),
                                      };
                                    }).toList();
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
                                                  label: Text('No Antrean',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.white))),
                                              DataColumn(
                                                  label: Text('Username',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.white))),
                                              DataColumn(
                                                  label: Text('Tanggal Pelayanan',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.white))),
                                              DataColumn(
                                                  label: Text('Tipe Antrean',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.white))),
                                              DataColumn(
                                                  label: Text('Jam Daftar',
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
                                            rows: daftarAntrean
                                                .map((antrean) => DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                    states) {
                                                      if (antrean[
                                                      'status_antrean'] ==
                                                          "4") {
                                                        return Colors.red[100];
                                                      } else {
                                                        return Colors.white;
                                                      }
                                                    }),
                                                cells: [
                                                  DataCell(Text(antrean[
                                                  'nomor_antrean'])),
                                                  DataCell(Text(
                                                      antrean['username'])),
                                                  DataCell(Text(antrean[
                                                  'tgl_pelayanan'])),
                                                  DataCell(Text((antrean[
                                                  'tipe_booking'] ==
                                                      "1")
                                                      ? "Booking"
                                                      : "Umum")),
                                                  DataCell(Text(antrean[
                                                  'jam_daftar_antrean'] +
                                                      " WIB")),
                                                  DataCell(Row(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(Icons
                                                              .access_time_sharp),
                                                          onPressed: () {}),
                                                      IconButton(
                                                          icon: Icon(
                                                              Icons.edit),
                                                          onPressed: () {}),
                                                      IconButton(
                                                          icon: Icon(
                                                              Icons.delete),
                                                          onPressed: () {})
                                                    ],
                                                  )),
                                                ]))
                                                .toList(),
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
          if (state is StateRiwayatGetPoliFailed) {
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
          title: Text("Daftar Riwayat Kunjungan"),
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
          title: Text("Daftar Riwayat Kunjungan"),
        ),
        body: Container(
          color: Colors.teal[50],
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
