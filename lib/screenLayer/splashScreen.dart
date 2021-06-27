import 'package:flutter/material.dart';
import 'package:web_antrean_babatan/dataLayer/session/sharedPref.dart';
import 'package:web_antrean_babatan/utils/color.dart';

import 'loginScreen.dart';
import 'mainScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var duration = const Duration(seconds: 3);

  Future<bool> isSession() async {
    bool result = await SharedPref.isLogin();
    return result;
  }

  void changePage() async {
    bool isFound = await isSession();
    if (isFound) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  void afterFirstLayout(BuildContext context) {
    new Future.delayed(duration, changePage);
  }

  @override
  void initState() {
    afterFirstLayout(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Image(
                height: 64.0,
                image: AssetImage('asset/LogoPuskesmas.png'),
              ),
            ),
            Container(
              child: Center(
                child: Text('Selamat Datang',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.greenDark)),
              ),
            ),
            Container(
              child: Center(
                child: Text('Antrean Online Puskesmas Babatan',
                    style: TextStyle(
                        fontSize: 16.0, color: ColorTheme.greenDark)),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.fromLTRB(48.0, 16.0, 48.0, 16.0),
                child: LinearProgressIndicator()),
            Container(
              child: Text("Ver 1.0.0"),
            )
          ],
        ));
  }
}
