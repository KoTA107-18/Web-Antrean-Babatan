import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_antrean_babatan/blocLayer/poliklinik/poliklinik_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/model/hari.dart';
import 'package:web_antrean_babatan/dataLayer/model/hariPelayanan.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwal.dart';
import 'package:web_antrean_babatan/utils/color.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
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
            backgroundColor: Colors.teal[50],
            appBar: AppBar(
              leading: Icon(Icons.local_hospital),
              title: Text("Daftar Poliklinik"),
              actions: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // background
                      onPrimary: ColorTheme.greenDark, // foreground
                    ),
                    child: Text(
                      'Tambah Data',
                      style: TextStyle(color: ColorTheme.greenDark),
                    ),
                    onPressed: () {
                      addDialog();
                    },
                  ),
                )
              ],
            ),
            body: BlocBuilder<PoliklinikBloc, PoliklinikState>(
              bloc: _poliklinikBloc,
              builder: (BuildContext context, state) {
                if (state is StatePoliklinikSuccess) {
                  return Container(
                      padding: EdgeInsets.all(20.0),
                      child: daftarPoli(state.daftarPoli));
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
            )));
  }

  ListView daftarPoli(List<Poliklinik> daftarPoli) {
    return ListView(children: <Widget>[
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
                label: Text('Nama',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            DataColumn(
                label: Text('Jadwal',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            DataColumn(
                label: Text('Deskripsi',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            DataColumn(
                label: Text('Aksi',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
          ],
          rows: daftarPoli
              .map((poliklinik) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (poliklinik.statusPoli == 1) {
                          return Colors.white;
                        } else {
                          return Colors.red[100];
                        }
                      }),
                      cells: [
                        DataCell(Text(poliklinik.namaPoli)),
                        DataCell(Text(
                          poliklinik.jadwalToString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataCell((poliklinik.descPoli.length >= 50)
                            ? Text(
                                poliklinik.descPoli.substring(0, 50) + " ...")
                            : Text(poliklinik.descPoli)),
                        DataCell(Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  editDialog(poliklinik);
                                }),
                            IconButton(
                                icon: Icon(Icons.info),
                                onPressed: () {
                                  infoDialog(poliklinik);
                                })
                          ],
                        )),
                      ]))
              .toList(),
        ),
      ),
    ]);
  }

  addDialog() {
    List<HariPelayanan> hariPelayanan = [
      HariPelayanan(
          status: false,
          hari: "Senin",
          kodeHari: Hari.SENIN),
      HariPelayanan(
          status: false,
          hari: "Selasa",
          kodeHari: Hari.SELASA),
      HariPelayanan(
          status: false,
          hari: "Rabu",
          kodeHari: Hari.RABU),
      HariPelayanan(
          status: false,
          hari: "Kamis",
          kodeHari: Hari.KAMIS),
      HariPelayanan(
          status: false,
          hari: "Jumat",
          kodeHari: Hari.JUMAT),
      HariPelayanan(
          status: false,
          hari: "Sabtu",
          kodeHari: Hari.SABTU),
    ];

    TextEditingController _nama = TextEditingController();
    TextEditingController _desc = TextEditingController();
    TextEditingController _rataRata = TextEditingController();

    void submitPoliklinik() {
      List<Jadwal> resultHari = [];
      for(var i in hariPelayanan){
        if(i.status){
          resultHari.add(Jadwal(idPoli: 0,
              hari: i.kodeHari,
              jamBukaBooking: i.jamBukaBookingInput.text.toString(),
              jamTutupBooking: i.jamTutupBookingInput.text.toString()));
        }
      }
      Poliklinik dataPoliklinik = Poliklinik(
          namaPoli: _nama.text.toString(),
          descPoli: _desc.text.toString(),
          jadwal: resultHari,
          rerataWaktuPelayanan: int.parse(_rataRata.text.toString()));
      _poliklinikBloc
          .add(EventPoliklinikAddSubmitPoli(dataPoliklinik: dataPoliklinik));
    }

    Future _selectTime(BuildContext context, TextEditingController _timeController) async {
      TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
      final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 00, minute: 00),
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

    showDialog(
        context: context,
        builder: (context) {
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
                      child: textFieldModified(
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
                      child: textFieldModified(
                        label: "Deskripsi Poliklinik",
                        hint: "Masukkan deskripsi Poliklinik",
                        controller: _desc,
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
                      child: textFieldModified(
                        label: "Rata - Rata Waktu Pelayanan",
                        hint: "Masukkan perkiraan durasi dalam satuan menit",
                        controller: _rataRata,
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
                              child: textFieldModified(
                                  controller: i.jamBukaBookingInput,
                                  label: "Buka",
                                  isEnabled: false),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.update),
                                onPressed: () {
                                  if(i.status){
                                    _selectTime(context, i.jamBukaBookingInput);
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: textFieldModified(
                                  controller: i.jamTutupBookingInput,
                                  label: "Tutup",
                                  isEnabled: false),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.update),
                                onPressed: () {
                                  if(i.status){
                                    _selectTime(context, i.jamTutupBookingInput);
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
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text(
                    'Tambah',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    submitPoliklinik();
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
            );
          });
        });
  }

  editDialog(Poliklinik poliklinik) {
    TextEditingController _nama = TextEditingController();
    TextEditingController _deskripsi = TextEditingController();
    TextEditingController _ratarata = TextEditingController();
    _nama.text = poliklinik.namaPoli;
    _deskripsi.text = poliklinik.descPoli;
    _ratarata.text = poliklinik.rerataWaktuPelayanan.toString();
    bool _setiapHari, _senin, _selasa, _rabu, _kamis, _jumat, _sabtu;
    _setiapHari = _senin = _selasa = _rabu = _kamis = _jumat = _sabtu = true;

    validateCheckBox() {
      _setiapHari = (_senin && _selasa && _rabu && _kamis && _jumat && _sabtu);
    }

    void submitPoliklinik() {
      Map<String, dynamic> dataPoliklinik = {
        "id_poli": poliklinik.idPoli,
        "nama_poli": _nama.text,
        "desc_poli": _deskripsi.text,
        "status_poli": poliklinik.statusPoli,
        "rerata_waktu_pelayanan": _ratarata.text,
        "data_hari": [_senin, _selasa, _rabu, _kamis, _jumat, _sabtu]
      };
      _poliklinikBloc
          .add(EventPoliklinikEditSubmitPoli(dataPoliklinik: dataPoliklinik));
    }

    showDialog(
        context: context,
        builder: (context) {
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
                      child: textFieldModified(
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
                      child: textFieldModified(
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
                      child: textFieldModified(
                        label: "Rata - Rata Waktu Pelayanan",
                        hint: "Masukkan perkiraan durasi dalam satuan menit",
                        controller: _ratarata,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Hari Pelayanan Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _setiapHari,
                          onChanged: (value) {
                            setState(() {
                              _setiapHari = value;
                              _senin = _selasa = _rabu =
                                  _kamis = _jumat = _sabtu = _setiapHari;
                            });
                          },
                        ),
                        Text('Setiap Hari'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _senin,
                              onChanged: (value) {
                                setState(() {
                                  _senin = value;
                                  validateCheckBox();
                                });
                              },
                            ),
                            Text('Senin'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _selasa,
                              onChanged: (value) {
                                setState(() {
                                  _selasa = value;
                                  validateCheckBox();
                                });
                              },
                            ),
                            Text('Selasa'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _rabu,
                              onChanged: (value) {
                                setState(() {
                                  _rabu = value;
                                  validateCheckBox();
                                });
                              },
                            ),
                            Text('Rabu'),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _kamis,
                              onChanged: (value) {
                                setState(() {
                                  _kamis = value;
                                  validateCheckBox();
                                });
                              },
                            ),
                            Text('Kamis'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _jumat,
                              onChanged: (value) {
                                setState(() {
                                  _jumat = value;
                                  validateCheckBox();
                                });
                              },
                            ),
                            Text('Jumat'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _sabtu,
                              onChanged: (value) {
                                setState(() {
                                  _sabtu = value;
                                  validateCheckBox();
                                });
                              },
                            ),
                            Text('Sabtu'),
                          ],
                        )
                      ],
                    )
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
                    'Ubah',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    submitPoliklinik();
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
            );
          });
        });
  }

  infoDialog(Poliklinik poliklinik) {
    bool _senin, _selasa, _rabu, _kamis, _jumat, _sabtu;
    _senin = _selasa = _rabu = _kamis = _jumat = _sabtu = false;

    for (var i = 0; i < poliklinik.jadwal.length; i++) {
      if (poliklinik.jadwal[i].hari == Hari.SENIN) {
        _senin = true;
      }

      if (poliklinik.jadwal[i].hari == Hari.SELASA) {
        _selasa = true;
      }

      if (poliklinik.jadwal[i].hari == Hari.RABU) {
        _rabu = true;
      }

      if (poliklinik.jadwal[i].hari == Hari.KAMIS) {
        _kamis = true;
      }

      if (poliklinik.jadwal[i].hari == Hari.JUMAT) {
        _jumat = true;
      }

      if (poliklinik.jadwal[i].hari == Hari.SABTU) {
        _sabtu = true;
      }
    }

    showDialog(
        context: context,
        builder: (context) {
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
                      child: Text('Status Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                          (poliklinik.idPoli == 1) ? "Aktif" : "Tidak Aktif"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _senin,
                              onChanged: null,
                            ),
                            Text('Senin'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _selasa,
                              onChanged: null,
                            ),
                            Text('Selasa'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _rabu,
                              onChanged: null,
                            ),
                            Text('Rabu'),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _kamis,
                              onChanged: null,
                            ),
                            Text('Kamis'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _jumat,
                              onChanged: null,
                            ),
                            Text('Jumat'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _sabtu,
                              onChanged: null,
                            ),
                            Text('Sabtu'),
                          ],
                        )
                      ],
                    )
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
                )
              ],
            );
          });
        });
  }
}
