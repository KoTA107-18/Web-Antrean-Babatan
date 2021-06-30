import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_antrean_babatan/blocLayer/antrean/tambahAntrean/tambahantrean_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/utils/color.dart';
import 'package:web_antrean_babatan/utils/loading.dart';
import 'package:web_antrean_babatan/utils/textFieldModified.dart';

class TambahAntreanScreen extends StatefulWidget {
  @override
  _TambahAntreanScreenState createState() => _TambahAntreanScreenState();
}

class _TambahAntreanScreenState extends State<TambahAntreanScreen> {
  TambahantreanBloc _tambahantreanBloc = TambahantreanBloc();

  Future _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1945),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    return selectedDate;
  }

  buatAkun() {
    bool isClickValidated = false;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    DateTime selectedDate = DateTime.now();
    TextEditingController _namaLengkap = TextEditingController();
    TextEditingController _tglLahir = TextEditingController();
    TextEditingController _alamat = TextEditingController();
    TextEditingController _kepalaKeluarga = TextEditingController();
    TextEditingController _username = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _passwordTwo = TextEditingController();
    TextEditingController _nomorHandphone = TextEditingController();

    void verifiedInput() {
      setState(() {
        isClickValidated = true;
      });
      if (_formKey.currentState.validate()) {
        Pasien _pasien = Pasien(
            username: _username.text,
            noHandphone: _nomorHandphone.text,
            kepalaKeluarga: _kepalaKeluarga.text,
            namaLengkap: _namaLengkap.text,
            password: _password.text,
            alamat: _alamat.text,
            tglLahir: _tglLahir.text);
        _tambahantreanBloc.add(EventTambahAntreanSubmitPasien(pasien: _pasien));
        //Navigator.pop(context);
      }
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
                  Text("Buat Akun Pasien Baru"),
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height * 3 / 4,
                child: Form(
                  autovalidateMode: (isClickValidated)
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  key: _formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Nama Lengkap',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: textFieldModified(
                            hint: 'Isi nama anda',
                            icon: Icon(Icons.person),
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z ]')),
                            ],
                            validatorFunc: (value) {
                              if (value.isEmpty) {
                                return "Harus diisi";
                              } else {
                                return null;
                              }
                            },
                            controller: _namaLengkap),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Tanggal Lahir',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: textFieldModified(
                                  isEnabled: false,
                                  hint: 'Tanggal Lahir',
                                  icon: Icon(Icons.date_range),
                                  controller: _tglLahir),
                            ),
                            SizedBox(width: 16.0),
                            ElevatedButton(
                                onPressed: () {
                                  _selectDate(context).then((value) {
                                    selectedDate = value;
                                    setState(() {
                                      _tglLahir.text =
                                          "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                    });
                                  });
                                },
                                child: Icon(Icons.date_range))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Alamat Lengkap',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: textFieldModified(
                            hint: 'Isi alamat rumah anda',
                            icon: Icon(Icons.map),
                            validatorFunc: (value) {
                              if (value.isEmpty) {
                                return "Harus diisi";
                              } else {
                                return null;
                              }
                            },
                            controller: _alamat),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Nama Kepala Keluarga',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: textFieldModified(
                            hint: 'Isi nama kepala keluarga anda',
                            icon: Icon(Icons.person),
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z ]')),
                            ],
                            validatorFunc: (value) {
                              if (value.isEmpty) {
                                return "Harus diisi";
                              } else {
                                return null;
                              }
                            },
                            controller: _kepalaKeluarga),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Username',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: textFieldModified(
                            hint: 'Kombinasi huruf dan angka.',
                            icon: Icon(Icons.person),
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9]')),
                            ],
                            validatorFunc: (value) {
                              if (value.isEmpty) {
                                return "Harus diisi";
                              } else if (value.length < 4) {
                                return "Minimum 4 karakter";
                              } else {
                                return null;
                              }
                            },
                            controller: _username),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Password',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: textFieldModified(
                            hint: 'Isi password anda',
                            icon: Icon(Icons.vpn_key),
                            formatter: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            ],
                            isPasword: true,
                            validatorFunc: (value) {
                              if (value.isEmpty) {
                                return "Harus diisi";
                              } else if (value.length < 4) {
                                return "Minimum 4 karakter";
                              } else {
                                return null;
                              }
                            },
                            controller: _password),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Konfirmasi Password',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: textFieldModified(
                            hint: 'Isi kembali password anda',
                            icon: Icon(Icons.vpn_key),
                            formatter: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            ],
                            isPasword: true,
                            validatorFunc: (value) {
                              if (value.isEmpty) {
                                return "Harus diisi";
                              } else if (value.length < 4) {
                                return "Minimum 4 karakter";
                              } else if (value != _password.text) {
                                return "Konfirmasi Password tidak sesuai";
                              } else {
                                return null;
                              }
                            },
                            controller: _passwordTwo),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Nomor Seluler',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: textFieldModified(
                            hint: 'Isi dengan nomor seluler anda',
                            icon: Icon(Icons.call),
                            typeKeyboard: TextInputType.number,
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            validatorFunc: (value) {
                              if (value.isEmpty) {
                                return "Harus diisi";
                              } else if (value.length < 10) {
                                return "Minimum 10 digit";
                              } else if (value.substring(0,2) != "62"){
                                return "Format tidak sesuai, awali dengan 62";
                              }  else {
                                return null;
                              }
                            },
                            controller: _nomorHandphone),
                      ),
                    ],
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
                    'Tambah',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    verifiedInput();
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

  @override
  void initState() {
    _tambahantreanBloc.add(EventTambahAntreanGetPoli());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _tambahantreanBloc,
      child: BlocListener<TambahantreanBloc, TambahantreanState>(
        bloc: _tambahantreanBloc,
        listener: (context, state) {
          if (state is StateTambahAntreanSubmitPasienSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Berhasil!",
                gravity: ToastGravity.CENTER,
                toastLength: Toast.LENGTH_LONG);
          }
          if (state is StateTambahAntreanSubmitPasienFailed) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: state.errMessage,
                gravity: ToastGravity.CENTER,
                toastLength: Toast.LENGTH_LONG);
          }
          if (state is StateTambahAntreanSubmitPasienLoading) {
            loading(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.local_hospital),
            title: Text("Tambah Antrean"),
            actions: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // background
                    onPrimary: ColorTheme.greenDark, // foreground
                  ),
                  child: Text(
                    'Buat Akun Pasien',
                    style: TextStyle(color: ColorTheme.greenDark),
                  ),
                  onPressed: () {
                    buatAkun();
                  },
                ),
              )
            ],
          ),
          body: Container(
            color: Colors.teal[50],
            child: BlocBuilder<TambahantreanBloc, TambahantreanState>(
              bloc: _tambahantreanBloc,
              builder: (context, state) {
                if (state is StateTambahAntreanGetPoliLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is StateTambahAntreanGetPoliFailed) {
                  return Center(
                    child: Text(state.errMessage),
                  );
                } else {
                  return formTambahAntrean(_tambahantreanBloc.daftarPoli);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Row formTambahAntrean(List<Poliklinik> daftarPoli) {
    DateTime selectedDate = DateTime.now();
    TextEditingController _namaLengkap = TextEditingController();
    TextEditingController _tglLahir = TextEditingController();
    TextEditingController _alamat = TextEditingController();
    TextEditingController _kepalaKeluarga = TextEditingController();
    TextEditingController _nomorHandphone = TextEditingController();
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Text('Nama Lengkap',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: textFieldModified(
                      hint: 'Isi nama anda',
                      icon: Icon(Icons.person),
                      formatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z ]')),
                      ],
                      validatorFunc: (value) {
                        if (value.isEmpty) {
                          return "Harus diisi";
                        } else {
                          return null;
                        }
                      },
                      controller: _namaLengkap),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Text('Tanggal Lahir',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Row(
                    children: [
                      Flexible(
                        child: textFieldModified(
                            isEnabled: false,
                            hint: 'Tanggal Lahir',
                            icon: Icon(Icons.date_range),
                            controller: _tglLahir),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                          onPressed: () {
                            _selectDate(context).then((value) {
                              selectedDate = value;
                              setState(() {
                                _tglLahir.text =
                                "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                              });
                            });
                          },
                          child: Icon(Icons.date_range))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Text('Alamat Lengkap',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: textFieldModified(
                      hint: 'Isi alamat rumah anda',
                      icon: Icon(Icons.map),
                      validatorFunc: (value) {
                        if (value.isEmpty) {
                          return "Harus diisi";
                        } else {
                          return null;
                        }
                      },
                      controller: _alamat),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Text('Nama Kepala Keluarga',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: textFieldModified(
                      hint: 'Isi nama kepala keluarga anda',
                      icon: Icon(Icons.person),
                      formatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z ]')),
                      ],
                      validatorFunc: (value) {
                        if (value.isEmpty) {
                          return "Harus diisi";
                        } else {
                          return null;
                        }
                      },
                      controller: _kepalaKeluarga),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Text('Nomor Seluler',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: textFieldModified(
                      hint: 'Isi dengan nomor seluler anda',
                      icon: Icon(Icons.call),
                      typeKeyboard: TextInputType.number,
                      formatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]')),
                      ],
                      validatorFunc: (value) {
                        if (value.isEmpty) {
                          return "Harus diisi";
                        } else if (value.length < 10) {
                          return "Minimum 10 digit";
                        } else if (value.substring(0,2) != "62"){
                          return "Format tidak sesuai, awali dengan 62";
                        }  else {
                          return null;
                        }
                      },
                      controller: _nomorHandphone),
                )
              ],
            ),
          ),
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
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Pilih Poliklinik yang dituju",
                        prefixIcon: Icon(Icons.local_hospital),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0))),
                    items: daftarPoli.map((value) {
                      return DropdownMenuItem(
                        child: Text(value.namaPoli),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      _tambahantreanBloc
                          .add(EventTambahAntreanSubmitPoliTujuan(poliklinik: value));
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: BlocBuilder<TambahantreanBloc, TambahantreanState>(
                    bloc: _tambahantreanBloc,
                    builder: (context, state) {
                      if (state is StateTambahAntreanPilihJenisPasien) {
                        return Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: state.isUmum,
                              onChanged: (result) {
                                _tambahantreanBloc.add(EventTambahAntreanRadioUmum());
                              },
                            ),
                            Text(
                              'Umum',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            Radio(
                              value: 1,
                              groupValue: state.isUmum,
                              onChanged: (result) {
                                _tambahantreanBloc.add(EventTambahAntreanRadioBPJS());
                              },
                            ),
                            Text(
                              'BPJS',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: _tambahantreanBloc.jenisPasien,
                              onChanged: (result) {
                                _tambahantreanBloc.add(EventTambahAntreanRadioUmum());
                              },
                            ),
                            Text(
                              'Umum',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            Radio(
                              value: 1,
                              groupValue: _tambahantreanBloc.jenisPasien,
                              onChanged: (result) {
                                _tambahantreanBloc.add(EventTambahAntreanRadioBPJS());
                              },
                            ),
                            Text(
                              'BPJS',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                            onPressed: () {
                              //_tambahantreanBloc.add(EventTambahAntreanSubmitAntreanBaru(username: _username.text));
                            },
                            child: Text("Antrean Normal")),
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
                              //_tambahantreanBloc.add(EventTambahAntreanSubmitAntreanBaru(username: _username.text));
                            },
                            child: Text("Antrean Gawat")),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
