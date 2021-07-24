import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:web_antrean_babatan/blocLayer/antrean/riwayatKunjungan/riwayat_kunjungan_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwalPasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/responseAntrean.dart';

class RiwayatScreen extends StatefulWidget {
  @override
  _RiwayatScreenState createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  int nomor;
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
        cubit: _riwayatKunjunganBloc,
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
                            future: RequestApi.getAntreanRiwayat(
                                state.daftarPoli[index].idPoli.toString(), _riwayatKunjunganBloc.apiToken),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                nomor = 0;
                                List<ResponseAntrean> daftarAntrean = [];
                                var resultSnapshot = snapshot.data as List;
                                daftarAntrean = resultSnapshot
                                    .map(
                                        (aJson) => ResponseAntrean.fromJson(aJson))
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
                                                  DataCell(Text(
                                                      i.pasien.namaLengkap)),
                                                  DataCell(Text(
                                                      (i.pasien.tglLahir ==
                                                          null)
                                                          ? "-"
                                                          : i.pasien.tglLahir)),
                                                  DataCell(Text((i.pasien
                                                      .kepalaKeluarga ==
                                                      null)
                                                      ? "-"
                                                      : i.pasien
                                                      .kepalaKeluarga)),
                                                  DataCell(Text(
                                                      (i.pasien.jenisPasien ==
                                                          0.toString())
                                                          ? "Umum"
                                                          : "BPJS")),
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

  infoAntrean(BuildContext context, ResponseAntrean pasien) {
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
                  child: Text((pasien.pasien.username == null)
                      ? "-"
                      : pasien.pasien.username),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Nama Lengkap',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.pasien.namaLengkap == null)
                      ? "-"
                      : pasien.pasien.namaLengkap),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('No Handphone',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.pasien.noHandphone == null)
                      ? "-"
                      : pasien.pasien.noHandphone),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Kepala Keluarga',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.pasien.kepalaKeluarga == null)
                      ? "-"
                      : pasien.pasien.kepalaKeluarga),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Tanggal Lahir',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.pasien.tglLahir == null)
                      ? "-"
                      : pasien.pasien.tglLahir),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Alamat',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.pasien.alamat == null)
                      ? "-"
                      : pasien.pasien.alamat),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jenis Pasien',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.pasien.jenisPasien == 0.toString())
                      ? "Umum"
                      : "BPJS"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Poliklinik Tujuan',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(pasien.poliklinik.namaPoli),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Nomor Antrean',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.nomorAntrean == null)
                      ? "0"
                      : pasien.nomorAntrean.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Tipe Booking',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.tipeBooking == 0.toString())
                      ? "Non Booking"
                      : "Booking"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Tanggal Pelayanan',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.tglPelayanan == null)
                      ? "-"
                      : pasien.tglPelayanan),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Waktu Daftar Antrean',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.waktuDaftarAntrean == null)
                      ? "-"
                      : pasien.waktuDaftarAntrean),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jam Booking',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.jamBooking == null)
                      ? "-"
                      : pasien.jamBooking),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jam Mulai Dilayani',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.jamMulaiDilayani == null)
                      ? "-"
                      : pasien.jamMulaiDilayani.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jam Selesai Dilayani',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.jamSelesaiDilayani == null)
                      ? "-"
                      : pasien.jamSelesaiDilayani.toString()),
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
