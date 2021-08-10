import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_antrean_babatan/blocLayer/antrean/tambahAntrean/tambahantrean_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/utils/constants/animations.dart';
import 'package:web_antrean_babatan/utils/constants/colors.dart';
import 'package:web_antrean_babatan/utils/loading.dart';
import 'package:web_antrean_babatan/utils/scrollColumnExpandable.dart';
import 'package:web_antrean_babatan/utils/textFieldModified.dart';

class TambahAntreanScreen extends StatefulWidget {
  @override
  _TambahAntreanScreenState createState() => _TambahAntreanScreenState();
}

class _TambahAntreanScreenState extends State<TambahAntreanScreen> {
  TambahantreanBloc _tambahantreanBloc = TambahantreanBloc();
  var sizeWidth = 0;

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
            latitude: 0.toString(),
            longitude: 0.toString(),
            tglLahir: _tglLahir.text);
        _tambahantreanBloc.add(EventTambahAntreanSubmitPasien(pasien: _pasien));
        //Navigator.pop(context);
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
                        child: TextFieldModified(
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
                              child: TextFieldModified(
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
                        child: TextFieldModified(
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
                        child: TextFieldModified(
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
                        child: TextFieldModified(
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
                        child: TextFieldModified(
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
                        child: TextFieldModified(
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
                        child: TextFieldModified(
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
                              } else if (value.substring(0, 2) != "62") {
                                return "Format tidak sesuai, awali dengan 62";
                              } else {
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
                      verifiedInput();
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

  @override
  void initState() {
    _tambahantreanBloc.add(EventTambahAntreanGetPoli());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sizeWidth = MediaQuery.of(context).size.width as int;
    print(sizeWidth.toString());
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
          if (state is StateTambahAntreanSubmitAntreanSuccess) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Berhasil!",
                gravity: ToastGravity.CENTER,
                toastLength: Toast.LENGTH_LONG);
          }
          if (state is StateTambahAntreanSubmitAntreanLoading) {
            loading(context);
          }
          if (state is StateTambahAntreanSubmitAntreanFailed) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: state.errMessage,
                gravity: ToastGravity.CENTER,
                toastLength: Toast.LENGTH_LONG);
          }
        },
        child: Scaffold(
          body: Container(
            color: AppColors.colorMap[50],
            child: SafeArea(
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
      ),
    );
  }

  formTambahAntrean(List<Poliklinik> daftarPoli) {
    DateTime selectedDate = DateTime.now();
    TextEditingController _namaLengkap = TextEditingController();
    TextEditingController _tglLahir = TextEditingController();
    TextEditingController _alamat = TextEditingController();
    TextEditingController _kepalaKeluarga = TextEditingController();
    TextEditingController _nomorHandphone = TextEditingController();
    return ScrollColumnExpandable(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
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
                          'Buat Akun Pasien',
                          style: TextStyle(color: AppColors.colorMap[50]),
                        ),
                      ),
                      onPressed: () {
                        buatAkun();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                        child: Text('Nama Lengkap',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                        child: TextFieldModified(
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
                            BlocBuilder<TambahantreanBloc, TambahantreanState>(
                              builder: (context, state) {
                                if (state is StateTambahAntreanPilihTanggal) {
                                  _tglLahir.text = _tambahantreanBloc.tglLahir;
                                  return Flexible(
                                    child: TextFieldModified(
                                        isEnabled: false,
                                        hint: 'Tanggal Lahir',
                                        icon: Icon(Icons.date_range),
                                        controller: _tglLahir),
                                  );
                                } else {
                                  _tglLahir.text = _tambahantreanBloc.tglLahir;
                                  return Flexible(
                                    child: TextFieldModified(
                                        isEnabled: false,
                                        hint: 'Tanggal Lahir',
                                        icon: Icon(Icons.date_range),
                                        controller: _tglLahir),
                                  );
                                }
                              },
                            ),
                            SizedBox(width: 16.0),
                            ElevatedButton(
                                onPressed: () {
                                  _selectDate(context).then((value) {
                                    selectedDate = value;
                                    _tglLahir.text =
                                        "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                    _tambahantreanBloc.add(
                                        EventTambahAntreanPilihTanggal(
                                            tanggal: _tglLahir.text));
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
                        child: TextFieldModified(
                            hint: 'Isi alamat rumah anda',
                            icon: Icon(Icons.map),
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
                        child: TextFieldModified(
                            hint: 'Isi nama kepala keluarga anda',
                            icon: Icon(Icons.person),
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z ]')),
                            ],
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
                        child: TextFieldModified(
                            hint: 'Isi dengan nomor seluler anda',
                            icon: Icon(Icons.call),
                            typeKeyboard: TextInputType.number,
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            controller: _nomorHandphone),
                      ),
                      (sizeWidth >= 992)
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 16.0, 0),
                              child: Text('Poliklinik',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                      (sizeWidth >= 992)
                          ? SizedBox.shrink()
                          : Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                              child: kolomKanan(
                                  daftarPoli,
                                  _namaLengkap,
                                  _nomorHandphone,
                                  _kepalaKeluarga,
                                  _alamat,
                                  _tglLahir),
                            )
                    ],
                  ),
                ),
              ),
              (sizeWidth >= 992)
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(8.0),
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
                            kolomKanan(
                                daftarPoli,
                                _namaLengkap,
                                _nomorHandphone,
                                _kepalaKeluarga,
                                _alamat,
                                _tglLahir),
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  kolomKanan(
      List<Poliklinik> daftarPoli,
      TextEditingController _namaLengkap,
      TextEditingController _nomorHandphone,
      TextEditingController _kepalaKeluarga,
      TextEditingController _alamat,
      TextEditingController _tglLahir) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
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
                      if (_tambahantreanBloc.poliklinikTujuan == null ||
                          _namaLengkap.text == "") {
                        Fluttertoast.showToast(
                          msg: "Lengkapi form!",
                          gravity: ToastGravity.CENTER,
                        );
                      } else {
                        var pasien = Pasien(
                            noHandphone: _nomorHandphone.text,
                            kepalaKeluarga: _kepalaKeluarga.text,
                            namaLengkap: _namaLengkap.text,
                            alamat: _alamat.text,
                            tglLahir: _tglLahir.text);
                        _tambahantreanBloc.add(
                            EventTambahAntreanSubmitAntreanBaru(
                                pasien: pasien, isGawat: false));
                      }
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
                      if (_tambahantreanBloc.poliklinikTujuan == null ||
                          _namaLengkap.text == "") {
                        Fluttertoast.showToast(
                          msg: "Lengkapi form!",
                          gravity: ToastGravity.CENTER,
                        );
                      } else {
                        var pasien = Pasien(
                            noHandphone: _nomorHandphone.text,
                            kepalaKeluarga: _kepalaKeluarga.text,
                            namaLengkap: _namaLengkap.text,
                            alamat: _alamat.text,
                            tglLahir: _tglLahir.text);
                        _tambahantreanBloc.add(
                            EventTambahAntreanSubmitAntreanBaru(
                                pasien: pasien, isGawat: true));
                      }
                    },
                    child: Text("Antrean Gawat")),
              ),
            ],
          ),
        )
      ],
    );
  }
}
