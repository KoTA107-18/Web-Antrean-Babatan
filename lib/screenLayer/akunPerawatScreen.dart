import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/utils/color.dart';
import 'package:web_antrean_babatan/utils/textFieldModified.dart';

class AkunPerawatScreen extends StatefulWidget {
  @override
  _AkunPerawatScreenState createState() => _AkunPerawatScreenState();
}

class _AkunPerawatScreenState extends State<AkunPerawatScreen> {

  ListView tabelAkunPerawat(List<int> daftarAkun) {
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
          rows: daftarAkun
              .map((akun) => DataRow(
              color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.white;
                      }),
              cells: [
                DataCell(Text("1")),
                DataCell(Text(
                  "Andifauzy7",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text("********")),
                DataCell(Text("Poliklinik Umum")),
                DataCell(Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editAkunPerawat();
                        }),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteAkunPerawat();
                        })
                  ],
                )),
              ]))
              .toList(),
        ),
      ),
    ]);
  }

  editAkunPerawat(){
    List<String> daftarPoli = ["Poliklinik Umum", "Poliklinik Gigi"];
    TextEditingController _username = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _passwordTwo = TextEditingController();
    TextEditingController _nama = TextEditingController();
    Poliklinik poliklinik;

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
                        items: daftarPoli.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {

                        },
                      ),
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
                    'Ubah',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
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
            );
          });
        });
  }

  deleteAkunPerawat(){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Hapus Akun Perawat"),
          content: Text("Anda yakin menghapus Akun Perawat yang dipilih?"),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
              child: Text(
                'Ya',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
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

  addAkunPerawat(){
    List<String> daftarPoli = ["Poliklinik Umum", "Poliklinik Gigi"];
    TextEditingController _username = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _passwordTwo = TextEditingController();
    TextEditingController _nama = TextEditingController();
    Poliklinik poliklinik;

    showDialog(
        context: context,
        builder: (context) {
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
                        items: daftarPoli.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {

                        },
                      ),
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
                    'Tambah',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
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
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    List<int> daftarAngka = [1,2];
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: Icon(Icons.switch_account),
        title: Text("Daftar Akun Perawat"),
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
                addAkunPerawat();
              },
            ),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: tabelAkunPerawat(daftarAngka)),
    );
  }
}
