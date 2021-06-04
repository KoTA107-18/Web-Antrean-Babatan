import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_antrean_babatan/blocLayer/login/login_bloc.dart';
import 'package:web_antrean_babatan/utils/color.dart';
import 'package:web_antrean_babatan/utils/textFieldModified.dart';

import 'mainScreen.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool isClickValidated = false;
  LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: Scaffold(
        body: Container(
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
                            style: TextStyle(
                                fontSize: 16.0, color: ColorTheme.greenDark)),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      child: BlocBuilder<LoginBloc, LoginState>(
                        bloc: _loginBloc,
                        builder: (context, state){
                          if(state is StateLoginChooseRole){
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 0,
                                  groupValue: state.chooseRole,
                                  onChanged: (result) {
                                    _loginBloc.add(EventLoginChooseAdmin());
                                  },
                                ),
                                Text(
                                  'Administrator',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                Radio(
                                  value: 1,
                                  groupValue: state.chooseRole,
                                  onChanged: (result) {
                                    _loginBloc.add(EventLoginChoosePerawat());
                                  },
                                ),
                                Text(
                                  'Perawat',
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 0,
                                  groupValue: _loginBloc.choiceRole,
                                  onChanged: (result) {
                                    _loginBloc.add(EventLoginChooseAdmin());
                                  },
                                ),
                                Text(
                                  'Administrator',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                Radio(
                                  value: 1,
                                  groupValue: _loginBloc.choiceRole,
                                  onChanged: (result) {
                                    _loginBloc.add(EventLoginChoosePerawat());
                                  },
                                ),
                                Text(
                                  'Perawat',
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                      ),
                    ),
                    SizedBox(height: 16.0),
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
                    SizedBox(height: 20.0),
                    BlocBuilder<LoginBloc, LoginState>(
                        bloc: _loginBloc,
                        builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          authLogin(context);
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    BlocListener<LoginBloc, LoginState>(
                        bloc: _loginBloc,
                        child: SizedBox.shrink(),
                        listener: (context, state) {
                          if (state is StateLoginSuccess) {
                            Fluttertoast.showToast(
                                msg: state.message,
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_LONG);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()));
                          } else if (state is StateLoginFailed) {
                            Fluttertoast.showToast(
                                msg: state.errorMessage,
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_LONG);
                          }
                        }),
                    BlocBuilder<LoginBloc, LoginState>(
                        bloc: _loginBloc,
                        builder: (context, state) {
                      if (state is StateLoginLoading) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                child: Center(
                                  child: LinearProgressIndicator(),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void authLogin(BuildContext context) {
    isClickValidated = true;
    if (_formKey.currentState.validate()) {
      BlocProvider.of<LoginBloc>(context).add(
          EventTapLogin(username: _username.text, password: _password.text));
    }
  }
}
