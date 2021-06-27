
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_antrean_babatan/blocLayer/akun/akunPerawat/akun_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/model/perawat.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/utils/textFieldModified.dart';

class AkunScreen extends StatefulWidget {
  @override
  _AkunScreenState createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  final AkunBloc _akunBloc = AkunBloc();

  @override
  void initState() {
    _akunBloc.add(AkunEventGetData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _akunBloc,
      child: Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          leading: Icon(Icons.switch_account),
          title: Text("Akun Anda"),
        ),
        body: BlocBuilder<AkunBloc, AkunState>(
          bloc: _akunBloc,
          builder: (context, state) {
            if (state is AkunStateSuccess) {
              return Container(
                  padding: EdgeInsets.all(20.0),
                  child:
                  tabelAkunPerawat(state.daftarPerawat, state.daftarPoli));
            } else if (state is AkunStateFailed) {
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
    );
  }

  ListView tabelAkunPerawat(
      List<Perawat> daftarPerawat, List<Poliklinik> daftarPoli) {
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
                label: Text('ID',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            DataColumn(
                label: Text('Username',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            DataColumn(
                label: Text('Password',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            DataColumn(
                label: Text('Poliklinik',
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
          rows: daftarPerawat
              .map((akunPerawat) => DataRow(
              color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Colors.white;
                  }),
              cells: [
                DataCell(Text(akunPerawat.idPerawat.toString())),
                DataCell(Text(
                  akunPerawat.username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text("*" * akunPerawat.password.length)),
                DataCell(Text(akunPerawat.namaPoli)),
                DataCell(Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          infoAkunPerawat(akunPerawat);
                        }),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editAkunPerawat(daftarPoli, akunPerawat);
                        }),
                  ],
                )),
              ]))
              .toList(),
        ),
      ),
    ]);
  }

  infoAkunPerawat(Perawat perawat) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(width: 8.0),
                  Text("Info Akun Perawat"),
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
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
                      child: Text(perawat.nama),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Username',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(perawat.username),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Password',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        perawat.password,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(perawat.namaPoli),
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
                )
              ],
            );
          });
        });
  }

  editAkunPerawat(List<Poliklinik> daftarPoli, Perawat perawat) {
    bool isClickValidated = false;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController _username = TextEditingController();
    _username.text = perawat.username;
    TextEditingController _password = TextEditingController();
    _password.text = perawat.password;
    TextEditingController _passwordTwo = TextEditingController();
    _passwordTwo.text = perawat.password;
    TextEditingController _nama = TextEditingController();
    _nama.text = perawat.nama;
    int idPoliklinik = perawat.idPoli;

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8.0),
                  Text("Edit Akun Perawat"),
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
                            controller: _nama),
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
                      )
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
                    'Ubah',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      isClickValidated = true;
                    });
                    if (_formKey.currentState.validate()) {
                      _akunBloc.add(AkunEventSubmitEdit(
                          perawat: Perawat(
                              nama: _nama.text.toString(),
                              idPerawat: perawat.idPerawat,
                              username: _username.text.toString(),
                              password: _password.text.toString(),
                              idPoli: idPoliklinik)));
                      Navigator.pop(context);
                    }
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
}
