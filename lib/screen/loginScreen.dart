import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_antrean_babatan/network/api.dart';
import 'package:web_antrean_babatan/screen/mainScreen.dart';
import 'package:web_antrean_babatan/session/sharedPref.dart';
import 'package:web_antrean_babatan/utils/color.dart';
import 'package:web_antrean_babatan/utils/loading.dart';
import 'package:web_antrean_babatan/utils/textFieldModified.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool isClickValidated = false;

  void authLogin() {
    setState(() {
      isClickValidated = true;
    });
    if(_formKey.currentState.validate()){
      loading(context);
      RequestApi.loginAdministrator(_username.text, _password.text).then((value){
        Navigator.pop(context);
        if(value){
          SharedPref.saveLogin(_username.text).then((value){
            Fluttertoast.showToast(
                gravity: ToastGravity.CENTER,
                backgroundColor: ColorTheme.greenDark,
                msg: "Login berhasil!",
                toastLength: Toast.LENGTH_LONG);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          });
        } else {
          Fluttertoast.showToast(
              gravity: ToastGravity.CENTER,
              backgroundColor: ColorTheme.greenDark,
              msg: "Login gagal!",
              toastLength: Toast.LENGTH_LONG);
        }
      }).catchError((e){
        Navigator.pop(context);
        Fluttertoast.showToast(
            gravity: ToastGravity.CENTER,
            backgroundColor: ColorTheme.greenDark,
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: loginDesktopView());
  }

  Widget loginDesktopView() {
    return Container(
      color: ColorTheme.greenDark,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.all(16.0),
          width: 540,
          height: 480,
          child: Form(
            key: _formKey,
            autovalidateMode: (isClickValidated)
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: ListView(
              children: [
                Center(
                  child: Container(
                    width: 100.0,
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset('asset/LogoPuskesmas.png'),
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
                        style: TextStyle(fontSize: 16.0, color: ColorTheme.greenDark)),
                  ),
                ),
                SizedBox(height: 32.0),
                Container(
                  child: textFieldModified(
                      label: 'Username',
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
                SizedBox(height: 20.0),
                Container(
                  child: textFieldModified(
                      label: 'Password',
                      hint: 'Isi password anda',
                      icon: Icon(Icons.vpn_key),
                      formatter: [
                        FilteringTextInputFormatter.deny(
                            RegExp('[ ]')),
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
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    authLogin();
                  },
                  child: Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ColorTheme.greenDark,
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
      ),
    );
  }
}
