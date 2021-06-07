
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:web_antrean_babatan/blocLayer/antreanSelesai/antrean_selesai_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwalPasien.dart';

class AntreanSelesaiScreen extends StatefulWidget {
  @override
  _AntreanSelesaiScreenState createState() => _AntreanSelesaiScreenState();
}

class _AntreanSelesaiScreenState extends State<AntreanSelesaiScreen> {
  AntreanSelesaiBloc _antreanSelesaiBloc = AntreanSelesaiBloc();
  int nomor;

  @override
  void initState() {
    _antreanSelesaiBloc.add(EventAntreanSelesaiGetPoli());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _antreanSelesaiBloc,
      child: BlocBuilder<AntreanSelesaiBloc, AntreanSelesaiState>(
        bloc: _antreanSelesaiBloc,
        builder: (context, state) {
          if (state is StateAntreanSelesaiGetPoliSuccess) {
            return DefaultTabController(
                length: state.daftarPoli.length,
                child: Scaffold(
                    appBar: AppBar(
                      leading: Icon(Icons.people),
                      title: Text("Daftar Antrean Selesai"),
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
                                future: RequestApi.getAntreanSelesai(
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
                                                              icon:
                                                              Icon(Icons.info),
                                                              onPressed: () {
                                                                infoAntrean(
                                                                    context, i);
                                                              })
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
                                      color: Colors.teal[50],
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Lottie.asset(
                                              'asset/not_found.json',
                                              repeat: false,
                                              reverse: false,
                                              animate: true,
                                            ),
                                          ),
                                          Container(
                                            child: Text("Data kosong."),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      color: Colors.teal[50],
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                });
                          }),
                    )));
          }
          if (state is StateAntreanSelesaiGetPoliFailed) {
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
          title: Text("Daftar Antrean Selesai"),
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
          title: Text("Daftar Antrean Selesai"),
        ),
        body: Container(
          color: Colors.teal[50],
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }

  infoAntrean(BuildContext context, JadwalPasien pasien) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.info),
              SizedBox(width: 8.0),
              Text("Info Antrean"),
            ],
          ),
          content: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Username',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.username),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Nama Lengkap',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.namaLengkap),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('No Handphone',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.noHandphone),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Kepala Keluarga',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.kepalaKeluarga),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Tanggal Lahir',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.tglLahir),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Alamat',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.alamat),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jenis Pasien',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text("Umum"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Poliklinik Tujuan',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.namaPoli),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Nomor Antrean',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.nomorAntrean == null) ? "0" : pasien.nomorAntrean.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Tipe Booking',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.tipeBooking.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Tanggal Pelayanan',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.tglPelayanan),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jam Daftar Antrean',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.jamDaftarAntrean),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jam Mulai Dilayani',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.jamMulaiDilayani == null) ? "00:00:00" : pasien.jamMulaiDilayani.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jam Selesai Dilayani',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.jamSelesaiDilayani == null) ? "00:00:00" : pasien.jamSelesaiDilayani.toString()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // background
                onPrimary: Colors.white, // foreground
              ),
              child: Text(
                'Tutup',
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
