import 'package:flutter/material.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          leading: Icon(Icons.dashboard),
          title: Text("Dashboard"),
          actions: [
            Container(
                padding: EdgeInsets.all(16.0),
                child: Center(
                    child: Text(
                  "20 April 2021",
                  style: TextStyle(fontSize: 18.0),
                ))),
            Container(
                padding: EdgeInsets.all(16.0),
                child: Center(
                    child: Text(
                  "09.35 WIB",
                  style: TextStyle(fontSize: 18.0),
                )))
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: RequestApi.getAllPoliklinik(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var resultSnapshot = snapshot.data as List;
                List<Poliklinik> daftarPoli = resultSnapshot
                    .map((aJson) => Poliklinik.fromJson(aJson))
                    .toList();
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GridView.builder(
                        itemCount: daftarPoli.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1.7),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                right: 8, top: 8, bottom: 8, left: 4),
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 2,
                                  offset: Offset(0.5, 0.5),
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Poliklinik :",
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          8.0, 0.0, 8.0, 12.0),
                                      child: Text(
                                        daftarPoli[index].namaPoli,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          8.0, 0.0, 8.0, 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Antrean",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text("NULL"),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          8.0, 0.0, 8.0, 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Antrean Sementara",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text("NULL"),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          8.0, 0.0, 8.0, 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Nomor Antrean Saat Ini",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text("NULL"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
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
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left : 16.0, right: 16.0),
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("Edit"),
                              secondary: const Icon(Icons.lock),
                              onChanged: (bool value) {
                                setState(() {
                                  edit = value;
                                });
                              },
                              value: edit,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text("Buka Portal")),
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red, // background
                                        onPrimary: Colors.white, // foreground
                                      ),
                                      onPressed: () {},
                                      child: Text("Tutup Portal")),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child:
                                  StatefulBuilder(builder: (context, setState) {
                                return ListView.builder(
                                    itemCount: daftarPoli.length,
                                    itemBuilder: (context, index) {
                                      return CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: Text(daftarPoli[index].namaPoli),
                                        secondary:
                                            const Icon(Icons.local_hospital),
                                        onChanged: (edit) ? (bool value) {
                                          setState(() {
                                            (value)
                                                ? daftarPoli[index].statusPoli =
                                            1
                                                : daftarPoli[index].statusPoli =
                                            0;
                                          });
                                        } : null,
                                        value:
                                            (daftarPoli[index].statusPoli == 1)
                                                ? true
                                                : false,
                                      );
                                    });
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
