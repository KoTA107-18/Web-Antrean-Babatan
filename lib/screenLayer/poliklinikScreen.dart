import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web_antrean_babatan/blocLayer/poliklinik/poliklinik_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/model/hari.dart';
import 'package:web_antrean_babatan/dataLayer/model/hariPelayanan.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwal.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/utils/constants/animations.dart';
import 'package:web_antrean_babatan/utils/constants/colors.dart';
import 'package:web_antrean_babatan/utils/textFieldModified.dart';

class PoliklinikScreen extends StatefulWidget {
  @override
  _PoliklinikScreenState createState() => _PoliklinikScreenState();
}

class _PoliklinikScreenState extends State<PoliklinikScreen> {
  final PoliklinikBloc _poliklinikBloc = PoliklinikBloc();

  @override
  void initState() {
    _poliklinikBloc.add(EventPoliklinikGetPoli());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _poliklinikBloc,
      child: Scaffold(
        backgroundColor: AppColors.colorMap[50],
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: SafeArea(
            child: BlocBuilder<PoliklinikBloc, PoliklinikState>(
              bloc: _poliklinikBloc,
              builder: (BuildContext context, state) {
                if (state is StatePoliklinikSuccess) {
                  return daftarPoli(state.daftarPoli);
                } else if (state is StatePoliklinikFailed) {
                  return Center(
                    child: Text(state.messageFailed),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  daftarPoli(List<Poliklinik> daftarPoli) {
    double cellWidth = 1481;
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryColor, // background
                                onPrimary: AppColors.colorMap[50], // foreground
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Tambah Data',
                                  style:
                                      TextStyle(color: AppColors.colorMap[50]),
                                ),
                              ),
                              onPressed: () {
                                addDialog();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: HorizontalDataTable(
                      leftHandSideColumnWidth: cellWidth / 6,
                      rightHandSideColumnWidth: cellWidth * 5 / 6,
                      isFixedHeader: true,
                      headerWidgets: getTitleWidget(
                          cellWidth / 6, (cellWidth - (cellWidth / 6))),
                      leftSideItemBuilder: (context, index) =>
                          generateFirstColumnRow(
                              context, index, daftarPoli, cellWidth / 6),
                      rightSideItemBuilder: (context, index) =>
                          generateRightHandSideColumnRow(context, index,
                              daftarPoli, (cellWidth - (cellWidth / 6))),
                      itemCount: daftarPoli.length,
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
      getTitleItemWidget('Nama', leftColumn),
      getTitleItemWidget('Jadwal', rightColumn * 3 / 12),
      getTitleItemWidget('Deskripsi', rightColumn * 8 / 12),
      getTitleItemWidget('Aksi', rightColumn / 12),
    ];
  }

  Widget generateFirstColumnRow(BuildContext context, int index,
      List<Poliklinik> daftarPoli, double width) {
    return Container(
      child: Text(daftarPoli[index].namaPoli),
      color: (daftarPoli[index].statusPoli == 1.toString())
          ? AppColors.white
          : AppColors.colorMap[900].withOpacity(0.4),
      width: width,
      height: 52,
      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget generateRightHandSideColumnRow(BuildContext context, int index,
      List<Poliklinik> daftarPoli, double width) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            daftarPoli[index].jadwalToString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          color: (daftarPoli[index].statusPoli == 1.toString())
              ? AppColors.white
              : AppColors.colorMap[900].withOpacity(0.4),
          width: width * 3 / 12,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text((daftarPoli[index].descPoli.length >= 50)
              ? daftarPoli[index].descPoli.substring(0, 50) + " ..."
              : daftarPoli[index].descPoli),
          color: (daftarPoli[index].statusPoli == 1.toString())
              ? AppColors.white
              : AppColors.colorMap[900].withOpacity(0.4),
          width: width * 8 / 12,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    editDialog(daftarPoli[index]);
                  }),
              IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    infoDialog(daftarPoli[index]);
                  })
            ],
          ),
          color: (daftarPoli[index].statusPoli == 1.toString())
              ? AppColors.white
              : AppColors.colorMap[900].withOpacity(0.4),
          width: width / 12,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Future _selectTimeOpen(
      BuildContext context, TextEditingController _timeController) async {
    TimeOfDay selectedTime = TimeOfDay(hour: 08, minute: 00);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 08, minute: 00),
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        var _hour = selectedTime.hour.toString().padLeft(2, '0');
        var _minute = selectedTime.minute.toString().padLeft(2, '0');
        var _time = _hour + ':' + _minute;
        _timeController.text = _time;
      });
  }

  Future _selectTimeClose(
      BuildContext context, TextEditingController _timeController) async {
    TimeOfDay selectedTime = TimeOfDay(hour: 15, minute: 00);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 15, minute: 00),
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        var _hour = selectedTime.hour.toString().padLeft(2, '0');
        var _minute = selectedTime.minute.toString().padLeft(2, '0');
        var _time = _hour + ':' + _minute;
        _timeController.text = _time;
      });
  }

  addDialog() {
    List<HariPelayanan> hariPelayanan = [
      HariPelayanan(status: false, hari: "Senin", kodeHari: Hari.SENIN),
      HariPelayanan(status: false, hari: "Selasa", kodeHari: Hari.SELASA),
      HariPelayanan(status: false, hari: "Rabu", kodeHari: Hari.RABU),
      HariPelayanan(status: false, hari: "Kamis", kodeHari: Hari.KAMIS),
      HariPelayanan(status: false, hari: "Jumat", kodeHari: Hari.JUMAT),
      HariPelayanan(status: false, hari: "Sabtu", kodeHari: Hari.SABTU),
    ];

    TextEditingController _nama = TextEditingController();
    TextEditingController _desc = TextEditingController();
    TextEditingController _rataRata = TextEditingController();
    TextEditingController _batasBooking = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool isClickValidated = false;

    void submitPoliklinik() {
      setState(() {
        isClickValidated = true;
      });
      if (_formKey.currentState.validate()) {
        List<Jadwal> resultHari = [];
        for (var i in hariPelayanan) {
          if (i.status) {
            resultHari.add(Jadwal(
                idPoli: 0,
                hari: i.kodeHari,
                jamBukaBooking: i.jamBukaBookingInput.text.toString(),
                jamTutupBooking: i.jamTutupBookingInput.text.toString()));
          }
        }
        Poliklinik dataPoliklinik = Poliklinik(
            namaPoli: _nama.text.toString(),
            descPoli: _desc.text.toString(),
            jadwal: resultHari,
            rerataWaktuPelayanan: _rataRata.text,
            statusPoli: 0.toString(),
            batasBooking: _batasBooking.text);
        confirmDialog(dataPoliklinik, true);
        // _poliklinikBloc.add(EventPoliklinikAddSubmitPoli(dataPoliklinik: dataPoliklinik));
        // Navigator.pop(context);
      }
    }

    showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 600),
        transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
          return Animations.fromTop(_animation, _secondaryAnimation, _child);
        },
        pageBuilder: (_animation, _secondaryAnimation, _child) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.add_circle),
                  SizedBox(width: 8.0),
                  Text("Tambah Poliklinik"),
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: Form(
                  autovalidateMode: (isClickValidated)
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  key: _formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Nama Poliklinik',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFieldModified(
                          label: "Nama Poliklinik",
                          hint: "Masukkan nama Poliklinik",
                          controller: _nama,
                          validatorFunc: (value) {
                            if (value.isEmpty) {
                              return "Harus diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Deskripsi Poliklinik',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFieldModified(
                          label: "Deskripsi Poliklinik",
                          hint: "Masukkan deskripsi Poliklinik",
                          controller: _desc,
                          validatorFunc: (value) {
                            if (value.isEmpty) {
                              return "Harus diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Rata Rata Waktu Pelayanan Poliklinik',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFieldModified(
                          label: "Rata - Rata Waktu Pelayanan",
                          hint: "Masukkan perkiraan durasi dalam satuan menit",
                          suffixIcon: Container(
                            decoration: BoxDecoration(
                                color: AppColors.colorMap[800],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16))),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Text(
                              "Menit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          controller: _rataRata,
                          formatter: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          validatorFunc: (value) {
                            if (value.isEmpty) {
                              return "Harus diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Batas Hari Maksimal Booking',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFieldModified(
                          label: "Batas Hari Maksimal Booking",
                          hint:
                              "Masukkan batas hari maksimal booking dalam satuan hari",
                          controller: _batasBooking,
                          suffixIcon: Container(
                            decoration: BoxDecoration(
                                color: AppColors.colorMap[800],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16))),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Text(
                              "Hari",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          formatter: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          validatorFunc: (value) {
                            if (value.isEmpty) {
                              return "Harus diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Hari Pelayanan Poliklinik',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      for (var i in hariPelayanan)
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: i.status,
                                      onChanged: (value) {
                                        setState(() {
                                          i.status = value;
                                        });
                                      },
                                    ),
                                    Text(i.hari)
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: TextFieldModified(
                                    controller: i.jamBukaBookingInput,
                                    label: "Buka",
                                    isEnabled: false),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.update),
                                  onPressed: () {
                                    if (i.status) {
                                      _selectTimeOpen(
                                          context, i.jamBukaBookingInput);
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: TextFieldModified(
                                    controller: i.jamTutupBookingInput,
                                    label: "Tutup",
                                    isEnabled: false),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.update),
                                  onPressed: () {
                                    if (i.status) {
                                      _selectTimeClose(
                                          context, i.jamTutupBookingInput);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
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
                        'Tambah',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      submitPoliklinik();
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
            );
          });
        });
  }

  editDialog(Poliklinik poliklinik) {
    TextEditingController _nama = TextEditingController();
    TextEditingController _deskripsi = TextEditingController();
    TextEditingController _ratarata = TextEditingController();
    TextEditingController _batasBooking = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool isClickValidated = false;
    _nama.text = poliklinik.namaPoli;
    _deskripsi.text = poliklinik.descPoli;
    _ratarata.text = poliklinik.rerataWaktuPelayanan.toString();
    _batasBooking.text = poliklinik.batasBooking.toString();

    List<HariPelayanan> hariPelayanan = [
      HariPelayanan(status: false, hari: "Senin", kodeHari: Hari.SENIN),
      HariPelayanan(status: false, hari: "Selasa", kodeHari: Hari.SELASA),
      HariPelayanan(status: false, hari: "Rabu", kodeHari: Hari.RABU),
      HariPelayanan(status: false, hari: "Kamis", kodeHari: Hari.KAMIS),
      HariPelayanan(status: false, hari: "Jumat", kodeHari: Hari.JUMAT),
      HariPelayanan(status: false, hari: "Sabtu", kodeHari: Hari.SABTU),
    ];

    for (var i = 0; i < poliklinik.jadwal.length; i++) {
      for (var j = 0; j < hariPelayanan.length; j++) {
        if (poliklinik.jadwal[i].hari == hariPelayanan[j].kodeHari) {
          hariPelayanan[j].status = true;
          hariPelayanan[j].jamBukaBookingInput.text =
              poliklinik.jadwal[i].jamBukaBooking;
          hariPelayanan[j].jamTutupBookingInput.text =
              poliklinik.jadwal[i].jamTutupBooking;
        }
      }
    }

    void submitPoliklinik() {
      setState(() {
        isClickValidated = true;
      });
      if (_formKey.currentState.validate()) {
        List<Jadwal> resultHari = [];
        for (var i in hariPelayanan) {
          if (i.status) {
            resultHari.add(Jadwal(
                idPoli: 0,
                hari: i.kodeHari,
                jamBukaBooking: i.jamBukaBookingInput.text.toString(),
                jamTutupBooking: i.jamTutupBookingInput.text.toString()));
          }
        }
        Poliklinik dataPoliklinik = Poliklinik(
            idPoli: poliklinik.idPoli,
            namaPoli: _nama.text.toString(),
            descPoli: _deskripsi.text.toString(),
            jadwal: resultHari,
            statusPoli: poliklinik.statusPoli,
            rerataWaktuPelayanan: _ratarata.text,
            batasBooking: _batasBooking.text);
        confirmDialog(dataPoliklinik, false);
        // _poliklinikBloc.add(EventPoliklinikEditSubmitPoli(dataPoliklinik: dataPoliklinik));
        // Navigator.pop(context);
      }
    }

    showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 600),
        transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
          return Animations.fromTop(_animation, _secondaryAnimation, _child);
        },
        pageBuilder: (_animation, _secondaryAnimation, _child) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8.0),
                  Text("Edit Poliklinik"),
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: Form(
                  autovalidateMode: (isClickValidated)
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  key: _formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Nama Poliklinik',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFieldModified(
                          label: "Nama Poliklinik",
                          hint: "Masukkan nama Poliklinik",
                          controller: _nama,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Deskripsi Poliklinik',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFieldModified(
                          label: "Deskripsi Poliklinik",
                          hint: "Masukkan deskripsi Poliklinik",
                          controller: _deskripsi,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Rata Rata Waktu Pelayanan Poliklinik',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFieldModified(
                          label: "Rata - Rata Waktu Pelayanan",
                          hint: "Masukkan perkiraan durasi dalam satuan menit",
                          controller: _ratarata,
                          suffixIcon: Container(
                            decoration: BoxDecoration(
                                color: AppColors.colorMap[800],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16))),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Text(
                              "Menit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Batas Hari Maksimal Booking',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFieldModified(
                          label: "Batas Hari Maksimal Booking",
                          hint:
                              "Masukkan batas hari maksimal booking dalam satuan hari",
                          controller: _batasBooking,
                          suffixIcon: Container(
                            decoration: BoxDecoration(
                                color: AppColors.colorMap[800],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16))),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Text(
                              "Hari",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Hari Pelayanan Poliklinik',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      for (var i in hariPelayanan)
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: i.status,
                                      onChanged: (value) {
                                        setState(() {
                                          i.status = value;
                                          if (i.status == false) {
                                            i.jamTutupBookingInput.clear();
                                            i.jamBukaBookingInput.clear();
                                          }
                                        });
                                      },
                                    ),
                                    Text(i.hari)
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: TextFieldModified(
                                    controller: i.jamBukaBookingInput,
                                    label: "Buka",
                                    isEnabled: false),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.update),
                                  onPressed: () {
                                    if (i.status) {
                                      _selectTimeOpen(
                                          context, i.jamBukaBookingInput);
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: TextFieldModified(
                                    controller: i.jamTutupBookingInput,
                                    label: "Tutup",
                                    isEnabled: false),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.update),
                                  onPressed: () {
                                    if (i.status) {
                                      _selectTimeClose(
                                          context, i.jamTutupBookingInput);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
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
                        'Ubah',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      submitPoliklinik();
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
            );
          });
        });
  }

  infoDialog(Poliklinik poliklinik) {
    List<HariPelayanan> hariPelayanan = [
      HariPelayanan(status: false, hari: "Senin", kodeHari: Hari.SENIN),
      HariPelayanan(status: false, hari: "Selasa", kodeHari: Hari.SELASA),
      HariPelayanan(status: false, hari: "Rabu", kodeHari: Hari.RABU),
      HariPelayanan(status: false, hari: "Kamis", kodeHari: Hari.KAMIS),
      HariPelayanan(status: false, hari: "Jumat", kodeHari: Hari.JUMAT),
      HariPelayanan(status: false, hari: "Sabtu", kodeHari: Hari.SABTU),
    ];

    for (var i = 0; i < poliklinik.jadwal.length; i++) {
      for (var j = 0; j < hariPelayanan.length; j++) {
        if (poliklinik.jadwal[i].hari == hariPelayanan[j].kodeHari) {
          hariPelayanan[j].status = true;
          hariPelayanan[j].jamBukaBookingInput.text =
              poliklinik.jadwal[i].jamBukaBooking;
          hariPelayanan[j].jamTutupBookingInput.text =
              poliklinik.jadwal[i].jamTutupBooking;
        }
      }
    }

    showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 600),
        transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
          return Animations.fromTop(_animation, _secondaryAnimation, _child);
        },
        pageBuilder: (_animation, _secondaryAnimation, _child) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(width: 8.0),
                  Text("Info Poliklinik"),
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Kode Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(poliklinik.idPoli.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Nama Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(poliklinik.namaPoli.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Desc Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        poliklinik.descPoli.toString(),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Rerata Waktu Pelayanan Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(poliklinik.rerataWaktuPelayanan.toString() +
                          " Menit"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Batas Hari Maksimal Booking',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(poliklinik.batasBooking.toString() + " Hari"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Status Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text((poliklinik.statusPoli == 1)
                          ? "Aktif"
                          : "Tidak Aktif"),
                    ),
                    for (var i in hariPelayanan)
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: i.status,
                                    onChanged: null,
                                  ),
                                  Text(i.hari)
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: TextFieldModified(
                                  controller: i.jamBukaBookingInput,
                                  label: "Buka",
                                  isEnabled: false),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 4,
                              child: TextFieldModified(
                                  controller: i.jamTutupBookingInput,
                                  label: "Tutup",
                                  isEnabled: false),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                      )
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
                )
              ],
            );
          });
        });
  }

  confirmDialog(Poliklinik poliklinik, bool isAdd) {
    List<HariPelayanan> hariPelayanan = [
      HariPelayanan(status: false, hari: "Senin", kodeHari: Hari.SENIN),
      HariPelayanan(status: false, hari: "Selasa", kodeHari: Hari.SELASA),
      HariPelayanan(status: false, hari: "Rabu", kodeHari: Hari.RABU),
      HariPelayanan(status: false, hari: "Kamis", kodeHari: Hari.KAMIS),
      HariPelayanan(status: false, hari: "Jumat", kodeHari: Hari.JUMAT),
      HariPelayanan(status: false, hari: "Sabtu", kodeHari: Hari.SABTU),
    ];

    for (var i = 0; i < poliklinik.jadwal.length; i++) {
      for (var j = 0; j < hariPelayanan.length; j++) {
        if (poliklinik.jadwal[i].hari == hariPelayanan[j].kodeHari) {
          hariPelayanan[j].status = true;
          hariPelayanan[j].jamBukaBookingInput.text =
              poliklinik.jadwal[i].jamBukaBooking;
          hariPelayanan[j].jamTutupBookingInput.text =
              poliklinik.jadwal[i].jamTutupBooking;
        }
      }
    }

    void submitPoliklinik() {
      if (isAdd) {
        _poliklinikBloc
            .add(EventPoliklinikAddSubmitPoli(dataPoliklinik: poliklinik));
      } else {
        _poliklinikBloc
            .add(EventPoliklinikEditSubmitPoli(dataPoliklinik: poliklinik));
      }
      Navigator.pop(context);
      Navigator.pop(context);
    }

    showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 600),
        transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
          return Animations.fromTop(_animation, _secondaryAnimation, _child);
        },
        pageBuilder: (_animation, _secondaryAnimation, _child) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(width: 8.0),
                  Text("Konfirmasi Data Poliklinik"),
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Nama Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(poliklinik.namaPoli.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Desc Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        poliklinik.descPoli.toString(),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Rerata Waktu Pelayanan Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(poliklinik.rerataWaktuPelayanan.toString() +
                          " Menit (${(60 / int.parse(poliklinik.rerataWaktuPelayanan)).floor().toString()} Orang / Jam)."),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Batas Hari Maksimal Booking',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(poliklinik.batasBooking.toString() + " Hari"),
                    ),
                    for (var i in hariPelayanan)
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: i.status,
                                    onChanged: null,
                                  ),
                                  Text(i.hari)
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFieldModified(
                                  controller: i.jamBukaBookingInput,
                                  label: "Buka",
                                  isEnabled: false),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFieldModified(
                                  controller: i.jamTutupBookingInput,
                                  label: "Tutup",
                                  isEnabled: false),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                      )
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
                        'Tambah',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      submitPoliklinik();
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
            );
          });
        });
  }
}
