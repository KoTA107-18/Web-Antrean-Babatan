import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
          child: GridView.builder(
            itemCount: 8,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.7),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 8, top: 8, bottom: 8, left: 4),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
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
                                  color: Colors.grey[600], fontSize: 14)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 12.0),
                          child: Text(
                            "Poliklinik Gigi",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Antrean",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text("20"),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Antrean Sementara",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text("3"),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nomor Antrean Saat Ini",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text("3"),
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
        ));
  }
}
