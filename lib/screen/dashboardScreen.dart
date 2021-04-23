import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        color: Colors.teal[50],
      ),
    );
  }
}
