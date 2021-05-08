import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_antrean_babatan/blocLayer/antrean/antrean_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';

class AntreanScreen extends StatefulWidget {
  @override
  _AntreanScreenState createState() => _AntreanScreenState();
}

class _AntreanScreenState extends State<AntreanScreen> {
  AntreanBloc _antreanBloc = AntreanBloc();

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
          if (state is StateAntreanGetPoliFailed) {
            return failedScreen(state.messageFailed);
          } else {
            return loadingScreen();
          }
        },
      ),
    );
  }
  /*
  DefaultTabController successScreen(List<Poliklinik> daftarPoli) {
    DaftarantreanBloc daftarantreanBloc = DaftarantreanBloc();
    return DefaultTabController(
      length: daftarPoli.length,
      child: BlocProvider(
        create: (context) => daftarantreanBloc,
        child: Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.people),
              title: Text("Daftar Antrean"),
              bottom: TabBar(
                isScrollable: true,
                tabs: List<Widget>.generate(daftarPoli.length, (int index) {
                  return Tab(text: daftarPoli[index].namaPoli);
                }),
              ),
            ),
            body: TabBarView(
              children: List<Widget>.generate(daftarPoli.length, (int index) {
                return BlocBuilder<DaftarantreanBloc, DaftarantreanState>(
                  bloc: daftarantreanBloc,
                  builder: (context, state) {
                    if (state is StateDaftarantreanGetSuccess) {
                      print("Sukses");
                      return SizedBox.shrink();
                    } else if (state is StateDaftarantreanGetFailed) {
                      print(state.messageFailed);
                      return SizedBox.shrink();
                    } else {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                );
              }),
            )),
      ),
    );
  }
  */

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

/*
class AntreanScreen extends StatefulWidget {
  @override
  _AntreanScreenState createState() => _AntreanScreenState();
}

class _AntreanScreenState extends State<AntreanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: Icon(Icons.people),
        title: Text("Daftar Antrean"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(children: <Widget>[
          DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(
                  label: Text('Antrean',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Nama Pasien',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Tanggal Lahir',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Kepala Keluarga',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Jenis',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Aksi',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
            ],
          ),
        ]),
      ),
    );
  }
}
*/
