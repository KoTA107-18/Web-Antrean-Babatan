import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:web_antrean_babatan/blocLayer/antrean/antreanSementara/antrean_sementara_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwalPasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/statusAntrean.dart';

class AntreanSementaraScreen extends StatefulWidget {
  @override
  _AntreanSementaraScreenState createState() => _AntreanSementaraScreenState();
}

class _AntreanSementaraScreenState extends State<AntreanSementaraScreen> {
  AntreanSementaraBloc _antreanSementaraBloc = AntreanSementaraBloc();
  int nomor;

  @override
  void initState() {
    _antreanSementaraBloc.add(EventAntreanSementaraGetPoli());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _antreanSementaraBloc,
      child: BlocBuilder<AntreanSementaraBloc, AntreanSementaraState>(
        cubit: _antreanSementaraBloc,
        builder: (context, state) {
          if (state is StateAntreanSementaraGetPoliSuccess) {
            return DefaultTabController(
                length: state.daftarPoli.length,
                child: Scaffold(
                    appBar: AppBar(
                      leading: Icon(Icons.people),
                      title: Text("Daftar Antrean Sementara"),
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
                                future: RequestApi.getAntreanSementara(
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
                                                      DataCell(Text((i.tglLahir == null) ? "-" : i.tglLahir)),
                                                      DataCell(
                                                          Text((i.kepalaKeluarga == null) ? "-" : i.kepalaKeluarga)),
                                                      DataCell(Text((i.jenisPasien == 0) ? "Umum" : "BPJS")),
                                                      DataCell(Row(
                                                        children: [
                                                          IconButton(
                                                              icon: Icon(Icons
                                                                  .access_time_sharp),
                                                              onPressed: () {
                                                                konfirmasiAntreanUtama(context, i);
                                                              }),
                                                          IconButton(
                                                              icon:
                                                              Icon(Icons.edit),
                                                              onPressed: () {
                                                                editAntrean(context, i);
                                                              }),
                                                          IconButton(
                                                              icon:
                                                              Icon(Icons.info),
                                                              onPressed: () {
                                                                infoAntrean(context, i);
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
          if (state is StateAntreanSementaraGetPoliFailed) {
            return failedScreen(state.messageFailed);
          } else {
            return loadingScreen();
          }
        },
      ),
    );
  }

  konfirmasiAntreanUtama(BuildContext context, JadwalPasien pasien) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Anda yakin memindahkan pasien yang dipilih ke Antrean Utama?"),
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
                pasien.statusAntrean = StatusAntrean.BELUM_DILAYANI;
                _antreanSementaraBloc.add(EventAntreanSementaraEditJadwalPasien(pasien: pasien));
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

  editAntrean(BuildContext context, JadwalPasien pasien) {
    Map result;
    List<Map> daftarStatus = [
      {
        'status' : "Belum Dilayani",
        'value' : 1
      },
      {
        'status' : "Sedang Dilayani",
        'value' : 2
      },
      {
        'status' : "Sudah Dilayani",
        'value' : 3
      },
      {
        'status' : "Dilewati",
        'value' : 4
      },
      {
        'status' : "Dibatalkan",
        'value' : 5
      }
    ];

    for(var i in daftarStatus){
      if(i['value'] == pasien.statusAntrean){
        result = i;
      }
    }
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(width: 8.0),
              Text("Ubah Status"),
            ],
          ),
          content: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: "Pilih Status",
                    prefixIcon: Icon(Icons.local_hospital),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0))),
                value: result["value"],
                items: daftarStatus.map((value) {
                  return DropdownMenuItem(
                    child: Text(value["status"]),
                    value: value["value"],
                  );
                }).toList(),
                onChanged: (value) {
                  result["value"] = value;
                },
              ),
            ),
          ),
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
                pasien.statusAntrean = result["value"];
                _antreanSementaraBloc
                    .add(EventAntreanSementaraEditJadwalPasien(pasien: pasien));
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
                  child: Text((pasien.username == null) ? "-" : pasien.username),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Nama Lengkap',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.namaLengkap == null) ? "-" : pasien.namaLengkap),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('No Handphone',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.noHandphone == null) ? "-" : pasien.noHandphone),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Kepala Keluarga',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.kepalaKeluarga == null) ? "-" : pasien.kepalaKeluarga),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Tanggal Lahir',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.tglLahir == null) ? "-" : pasien.tglLahir),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Alamat',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.alamat == null) ? "-" : pasien.alamat),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jenis Pasien',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.jenisPasien == 0) ? "Umum" : "BPJS"),
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
                  child: Text((pasien.tipeBooking == 0) ? "Non Booking" : "Booking"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Tanggal Pelayanan',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.tglPelayanan == null) ? "-" : pasien.tglPelayanan),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Waktu Daftar Antrean',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.waktuDaftarAntrean == null) ? "-" : pasien.waktuDaftarAntrean),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jam Booking',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.jamBooking == null) ? "-" : pasien.jamBooking),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jam Mulai Dilayani',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.jamMulaiDilayani == null) ? "-" : pasien.jamMulaiDilayani.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Jam Selesai Dilayani',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text((pasien.jamSelesaiDilayani == null) ? "-" : pasien.jamSelesaiDilayani.toString()),
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
          title: Text("Daftar Antrean Sementara"),
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
          title: Text("Daftar Antrean Sementara"),
        ),
        body: Container(
          color: Colors.teal[50],
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
