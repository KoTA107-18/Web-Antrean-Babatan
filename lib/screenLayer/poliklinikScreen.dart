import 'package:flutter/material.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/utils/color.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/utils/loading.dart';
import 'package:web_antrean_babatan/utils/textFieldModified.dart';

class PoliklinikScreen extends StatefulWidget {
  @override
  _PoliklinikScreenState createState() => _PoliklinikScreenState();
}

class _PoliklinikScreenState extends State<PoliklinikScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: FutureBuilder(
        future: RequestApi.getAllPoliklinik(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var resultSnapshot = snapshot.data as List;
            List<Poliklinik> daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
            return Container(
              padding: EdgeInsets.all(20.0),
              child: ListView(children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.teal,
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
                          label: Text('Waktu Buka',
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
                                  if(poliklinik.statusPoli == 1){
                                    return Colors.white;
                                  } else {
                                    return Colors.white70;
                                  }
                                }),
                                cells: [
                                  DataCell(Text(poliklinik.namaPoli)),
                                  DataCell(Text(
                                    "Belum diatur",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  DataCell(Text(
                                      poliklinik.descPoli.substring(0, 50) +
                                          " ...")),
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
              ]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  addDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        controller: null,
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
                        controller: null,
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
                        controller: null,
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

  editDialog(Poliklinik poliklinik) {
    TextEditingController _nama = TextEditingController();
    TextEditingController _deskripsi = TextEditingController();
    TextEditingController _ratarata = TextEditingController();
    _nama.text = poliklinik.namaPoli;
    _deskripsi.text = poliklinik.descPoli;
    _ratarata.text = poliklinik.rerataWaktuPelayanan.toString();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Poliklinik aPoliklinik = Poliklinik(
                        idPoli: int.parse(poliklinik.idPoli.toString()),
                        namaPoli: _nama.text.toString(),
                        descPoli: _deskripsi.text.toString(),
                        statusPoli:
                            int.parse(poliklinik.statusPoli.toString()),
                        rerataWaktuPelayanan: int.parse(_ratarata.text));
                    loading(context);
                    RequestApi.updatePoliklinik(aPoliklinik).then((value) {
                      Navigator.pop(context);
                      if (value) {
                        print("Sukses");
                      } else {
                        print("Gagal");
                      }
                    });
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

  deleteDialog(Poliklinik poliklinik) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8.0),
                  Text("Hapus Poliklinik"),
                ],
              ),
              content: Text("Anda yakin ingin menghapus data Poliklinik ini?"),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text(
                    'Hapus',
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

  infoDialog(Poliklinik poliklinik) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
            ));
  }
}
