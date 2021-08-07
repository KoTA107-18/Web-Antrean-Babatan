import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:lottie/lottie.dart';
import 'package:web_antrean_babatan/blocLayer/antrean/antreanSelesai/antrean_selesai_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwalPasien.dart';
import 'package:web_antrean_babatan/utils/constants/animations.dart';
import 'package:web_antrean_babatan/utils/constants/colors.dart';

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
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(kToolbarHeight - 3),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(child: Container()),
                              TabBar(
                                indicatorColor: AppColors.colorMap[50],
                                labelStyle: GoogleFonts.notoSans(),
                                unselectedLabelStyle: GoogleFonts.notoSans(),
                                isScrollable: true,
                                tabs: List<Widget>.generate(
                                  state.daftarPoli.length,
                                  (int index) {
                                    return Tab(
                                        text: state.daftarPoli[index].namaPoli);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                  color: AppColors.colorMap[50],
                                  padding: EdgeInsets.all(20.0),
                                  child: SafeArea(
                                    child: Row(children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: AppColors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x29000000),
                                                offset: Offset(0, 3),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: tabelAntreanSelesai(
                                              daftarAntrean),
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              } else if (snapshot.data == null &&
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                return Container(
                                  color: AppColors.colorMap[50],
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
                                  color: AppColors.colorMap[50],
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

  tabelAntreanSelesai(List<JadwalPasien> daftarAntrean) {
    double cellWidth = 1481;
    return HorizontalDataTable(
      leftHandSideColumnWidth: cellWidth * 12 / 36,
      rightHandSideColumnWidth: cellWidth * 24 / 36,
      isFixedHeader: true,
      headerWidgets: getTitleWidget(cellWidth * 12 / 36, cellWidth * 24 / 36),
      leftSideItemBuilder: (context, index) => generateFirstColumnRow(
          context, index, daftarAntrean, cellWidth * 12 / 36),
      rightSideItemBuilder: (context, index) => generateRightHandSideColumnRow(
          context, index, daftarAntrean, cellWidth * 24 / 36),
      itemCount: daftarAntrean.length,
      rowSeparatorWidget: const Divider(
        color: Colors.black45,
        height: 1.0,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: AppColors.white,
      rightHandSideColBackgroundColor: AppColors.white,
      verticalScrollbarStyle: const ScrollbarStyle(
        isAlwaysShown: true,
        thickness: 4.0,
        radius: Radius.circular(5.0),
      ),
      horizontalScrollbarStyle: const ScrollbarStyle(
        isAlwaysShown: true,
        thickness: 4.0,
        radius: Radius.circular(5.0),
      ),
    );
  }

  Widget getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      height: 56,
      width: width,
      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  List<Widget> getTitleWidget(double leftColumn, double rightColumn) {
    return [
      Row(
        children: [
          getTitleItemWidget('No', leftColumn * 4 / 12),
          getTitleItemWidget('Nama', leftColumn * 8 / 12)
        ],
      ),
      getTitleItemWidget('Tanggal Lahir', rightColumn * 8 / 24),
      getTitleItemWidget('Kepala Keluarga', rightColumn * 8 / 24),
      getTitleItemWidget('Jenis', rightColumn * 4 / 24),
      getTitleItemWidget('Aksi', rightColumn * 4 / 24),
    ];
  }

  Widget generateFirstColumnRow(BuildContext context, int index,
      List<JadwalPasien> daftarAntrean, double width) {
    return Row(
      children: [
        Container(
          child: Text((index + 1).toString()),
          color: AppColors.white,
          width: width * 4 / 12,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(daftarAntrean[index].namaLengkap),
          color: AppColors.white,
          width: width * 8 / 12,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Widget generateRightHandSideColumnRow(BuildContext context, int index,
      List<JadwalPasien> daftarAntrean, double width) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            (daftarAntrean[index].tglLahir == null)
                ? '-'
                : daftarAntrean[index].tglLahir,
          ),
          color: AppColors.white,
          width: width * 8 / 24,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            (daftarAntrean[index].kepalaKeluarga == null)
                ? '-'
                : daftarAntrean[index].kepalaKeluarga,
          ),
          color: AppColors.white,
          width: width * 8 / 24,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            (daftarAntrean[index].tipeBooking == 1) ? "Booking" : "Umum",
          ),
          color: AppColors.white,
          width: width * 4 / 24,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    infoAntrean(context, daftarAntrean[index]);
                  })
            ],
          ),
          color: AppColors.white,
          width: width * 4 / 24,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Scaffold failedScreen(String messageFailed) {
    return Scaffold(
        body: Container(
      color: AppColors.colorMap[50],
      child: Center(
        child: Text(messageFailed),
      ),
    ));
  }

  Scaffold loadingScreen() {
    return Scaffold(
        body: Container(
      color: AppColors.colorMap[50],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }

  infoAntrean(BuildContext context, JadwalPasien pasien) {
    showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 600),
        transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
          return Animations.fromTop(_animation, _secondaryAnimation, _child);
        },
        pageBuilder: (_animation, _secondaryAnimation, _child) => AlertDialog(
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
                      child: Text(pasien.waktuDaftarAntrean),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Jam Booking',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(pasien.jamBooking),
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
                          ? "00:00:00"
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
                          ? "00:00:00"
                          : pasien.jamSelesaiDilayani.toString()),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16.0, right: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tutup',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ));
  }
}
