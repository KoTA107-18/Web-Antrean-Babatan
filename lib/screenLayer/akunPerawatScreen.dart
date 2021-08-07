import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:web_antrean_babatan/blocLayer/akun/daftarAkunPerawat/akun_perawat_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/model/perawat.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/model/responseGetPerawat.dart';
import 'package:web_antrean_babatan/utils/constants/animations.dart';
import 'package:web_antrean_babatan/utils/constants/colors.dart';
import 'package:web_antrean_babatan/utils/textFieldModified.dart';

class AkunPerawatScreen extends StatefulWidget {
  @override
  _AkunPerawatScreenState createState() => _AkunPerawatScreenState();
}

class _AkunPerawatScreenState extends State<AkunPerawatScreen> {
  final AkunPerawatBloc _akunPerawatBloc = AkunPerawatBloc();
  int nomor = 0;

  @override
  void initState() {
    _akunPerawatBloc.add(AkunPerawatEventGetData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _akunPerawatBloc,
      child: Scaffold(
        backgroundColor: AppColors.colorMap[50],
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: BlocBuilder<AkunPerawatBloc, AkunPerawatState>(
              bloc: _akunPerawatBloc,
              builder: (context, state) {
                if (state is AkunPerawatStateSuccess) {
                  nomor = 0;
                  return tabelAkunPerawat(
                      state.daftarPerawat, state.daftarPoli);
                } else if (state is AkunPerawatStateFailed) {
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

  tabelAkunPerawat(
      List<ResponseGetPerawat> daftarPerawat, List<Poliklinik> daftarPoli) {
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
                                addAkunPerawat(daftarPoli);
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
                      leftHandSideColumnWidth: cellWidth * 9 / 30,
                      rightHandSideColumnWidth: cellWidth * 21 / 30,
                      isFixedHeader: true,
                      headerWidgets: getTitleWidget(
                          cellWidth * 9 / 30, cellWidth * 21 / 30),
                      leftSideItemBuilder: (context, index) =>
                          generateFirstColumnRow(context, index, daftarPerawat,
                              daftarPoli, cellWidth * 9 / 30),
                      rightSideItemBuilder: (context, index) =>
                          generateRightHandSideColumnRow(context, index,
                              daftarPerawat, daftarPoli, (cellWidth * 21 / 30)),
                      itemCount: daftarPerawat.length,
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
      Row(
        children: [
          getTitleItemWidget('No', leftColumn * 2 / 9),
          getTitleItemWidget('Username', leftColumn * 7 / 9),
        ],
      ),
      getTitleItemWidget('Password', rightColumn / 3),
      getTitleItemWidget('Poliklinik', rightColumn / 3),
      getTitleItemWidget('Aksi', rightColumn / 3),
    ];
  }

  Widget generateFirstColumnRow(
      BuildContext context,
      int index,
      List<ResponseGetPerawat> daftarPerawat,
      List<Poliklinik> daftarPoli,
      double width) {
    return Row(
      children: [
        Container(
          child: Text((index + 1).toString()),
          color: AppColors.white,
          width: width * 2 / 9,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            daftarPerawat[index].username,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          color: AppColors.white,
          width: width * 7 / 9,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        )
      ],
    );
  }

  Widget generateRightHandSideColumnRow(
      BuildContext context,
      int index,
      List<ResponseGetPerawat> daftarPerawat,
      List<Poliklinik> daftarPoli,
      double width) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            '*' * daftarPerawat[index].password.length,
          ),
          color: AppColors.white,
          width: width / 3,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(daftarPerawat[index].poliklinik.namaPoli),
          color: AppColors.white,
          width: width / 3,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    infoAkunPerawat(daftarPerawat[index]);
                  }),
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    editAkunPerawat(daftarPoli, daftarPerawat[index]);
                  }),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteAkunPerawat(
                        int.parse(daftarPerawat[index].idPerawat));
                  })
            ],
          ),
          color: AppColors.white,
          width: width / 3,
          height: 52,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  infoAkunPerawat(ResponseGetPerawat perawat) {
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
                      child: Text("*" * perawat.password.length),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Poliklinik',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(perawat.poliklinik.namaPoli),
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
                )
              ],
            );
          });
        });
  }

  editAkunPerawat(List<Poliklinik> daftarPoli, ResponseGetPerawat perawat) {
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
    int idPoliklinik = int.parse(perawat.idPoli);

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
                        child: Text('Poliklinik',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: "Pilih Poliklinik yang anda tuju",
                              prefixIcon: Icon(Icons.local_hospital),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0))),
                          value: idPoliklinik,
                          items: daftarPoli.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.namaPoli),
                              value: value.idPoli,
                            );
                          }).toList(),
                          onChanged: (value) {
                            idPoliklinik = value;
                          },
                        ),
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
                        'Ubah',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isClickValidated = true;
                      });
                      if (_formKey.currentState.validate()) {
                        _akunPerawatBloc.add(AkunPerawatEventSubmitEdit(
                            perawat: Perawat(
                                nama: _nama.text.toString(),
                                idPerawat: int.parse(perawat.idPerawat),
                                username: _username.text.toString(),
                                password: _password.text.toString(),
                                idPoli: idPoliklinik)));
                        Navigator.pop(context);
                      }
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

  deleteAkunPerawat(int idPerawat) {
    showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 600),
        transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
          return Animations.fromTop(_animation, _secondaryAnimation, _child);
        },
        pageBuilder: (_animation, _secondaryAnimation, _child) => AlertDialog(
              title: Text("Hapus Akun Perawat"),
              content: Text("Anda yakin menghapus Akun Perawat yang dipilih?"),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16.0, right: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Ya',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      _akunPerawatBloc.add(
                          AkunPerawatEventSubmitDelete(idPerawat: idPerawat));
                      Navigator.pop(context);
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
            ));
  }

  addAkunPerawat(List<Poliklinik> daftarPoli) {
    bool isClickValidated = false;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _username = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _passwordTwo = TextEditingController();
    TextEditingController _nama = TextEditingController();
    int idPoliklinik = 1;

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
                  Text("Tambah Akun Perawat"),
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: Form(
                  key: _formKey,
                  autovalidateMode: (isClickValidated)
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
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
                        child: Text('Poliklinik',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: "Pilih Poliklinik yang anda tuju",
                              prefixIcon: Icon(Icons.local_hospital),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0))),
                          value: idPoliklinik,
                          items: daftarPoli.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.namaPoli),
                              value: value.idPoli,
                            );
                          }).toList(),
                          onChanged: (value) {
                            idPoliklinik = value;
                          },
                        ),
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
                      setState(() {
                        isClickValidated = true;
                      });
                      if (_formKey.currentState.validate()) {
                        _akunPerawatBloc.add(AkunPerawatEventSubmitAdd(
                            perawat: Perawat(
                                nama: _nama.text.toString(),
                                username: _username.text.toString(),
                                password: _password.text.toString(),
                                idPoli: idPoliklinik)));
                        Navigator.pop(context);
                      }
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
