import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web_antrean_babatan/screen/dashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  void authLogin() {
    if (_username.text == "admin" && _password.text == "admin") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          // Check the sizing information here and return your UI
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return loginDesktopView();
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
            return loginDesktopView();
          }
          return loginMobileView();
        },
      ),
    );
  }

  Widget loginDesktopView() {
    return Container(
      color: Colors.teal[800],
      child: Center(
        child: Container(
          padding: EdgeInsets.all(64.0),
          color: Colors.white,
          width: 540,
          height: 480,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 100.0,
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset('asset/LogoPuskesmas.png'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Center(
                          child: Text('Selamat Datang.',
                              style: TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal)),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text('Antrean Online Puskesmas Babatan.',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.teal)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Container(
                child: TextField(
                  controller: _username,
                  decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.teal))),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: TextField(
                  controller: _password,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.vpn_key),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.teal))),
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  authLogin();
                },
                child: Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.teal,
                    elevation: 7.0,
                    child: Center(
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget loginMobileView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 100.0,
                padding: EdgeInsets.all(8.0),
                child: Image.asset('asset/LogoPuskesmas.png'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Center(
                    child: Text('Selamat Datang.',
                        style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal)),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('Antrean Online Puskesmas Babatan.',
                        style: TextStyle(fontSize: 16.0, color: Colors.teal)),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 32.0),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            controller: _username,
            decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(color: Colors.teal))),
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            controller: _password,
            decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.vpn_key),
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(color: Colors.teal))),
          ),
        ),
        SizedBox(height: 20.0),
        InkWell(
          onTap: () {
            authLogin();
          },
          child: Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            height: 40.0,
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.teal,
              elevation: 7.0,
              child: Center(
                child: Text(
                  'Masuk',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
