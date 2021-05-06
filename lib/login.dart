import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:load/load.dart';
import 'lost_item.dart';
import 'matches/matches.dart';
import 'auth.dart';
import 'package:flash/flash.dart';
import 'general_widgets.dart';
import 'notifications.dart';

const users = const {
  'bobo@bobo.sk': 'bobo',
  'hunter@gmail.com': 'hunter',
};

class RegistrationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController nickname = TextEditingController();
  TextEditingController telephone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  double padding = 10.0;
  double mleft = 20;
  double mright = 20;
  double mtop = 0;
  double mbottom = 0;
  double edgeRadius = 15.0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: EdgeInsets.only(left: 45, right: 45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(edgeRadius),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Form(
                key: _formKey,
                child: ListView(shrinkWrap: true, children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12, top: 10, bottom: 3),
                    child: Text(
                      "One more thing...",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                      // padding: EdgeInsets.all(padding),
                      padding: EdgeInsets.only(
                          left: mleft,
                          top: mtop,
                          bottom: mbottom,
                          right: mright),
                      child: TextFormField(
                        controller: email,
                        decoration: new InputDecoration(
                          labelText: 'Email',
                          // border: new OutlineInputBorder(
                          //   borderRadius: new BorderRadius.circular(edgeRadius),
                          //   borderSide: new BorderSide(),
                          // ),
                        ),
                        // ignore: missing_return
                        validator: (value) {
                          if (value == "") {
                            return "Missing email address";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              // ignore: missing_return
                              .hasMatch(value)) {
                            return "Invalid email format";
                          }
                          return null;
                        },
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: mleft,
                          top: mtop,
                          bottom: mbottom,
                          right: mright),
                      child: TextFormField(
                          controller: name,
                          decoration: new InputDecoration(
                            labelText: 'Full name',
                            // border: new OutlineInputBorder(
                            //   borderRadius: new BorderRadius.circular(edgeRadius),
                            //   borderSide: new BorderSide(),
                            // ),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return "Missing name";
                            }
                            return null;
                          })),
                  Padding(
                      padding: EdgeInsets.only(
                          left: mleft,
                          top: mtop,
                          bottom: mbottom,
                          right: mright),
                      child: TextFormField(
                          controller: nickname,
                          decoration: new InputDecoration(
                            labelText: 'Nickname',
                            // border: new OutlineInputBorder(
                            //   borderRadius: new BorderRadius.circular(edgeRadius),
                            //   borderSide: new BorderSide(),
                            // ),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return "Missing nickname";
                            }
                            return null;
                          })),
                  Padding(
                      padding: EdgeInsets.only(
                          left: mleft,
                          top: mtop,
                          bottom: mbottom,
                          right: mright),
                      child: TextFormField(
                          controller: telephone,
                          decoration: new InputDecoration(
                            labelText: 'Telephone number',
                            // border: new OutlineInputBorder(
                            //   borderRadius: new BorderRadius.circular(edgeRadius),
                            //   borderSide: new BorderSide(),
                            // ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "Missing telephone number";
                              // ignore: missing_return,
                            } else if (!RegExp(r"^\+[0-9]+").hasMatch(value)) {
                              return "Invalid number format. Please use +XXX...";
                            }
                            return null;
                          })),
                  Padding(
                    padding: EdgeInsets.only(
                        left: mleft, top: 20, bottom: 20, right: mright),
                    child: Container(
                        height: 55,
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Color.fromRGBO(0, 160, 227, 1))),
                            // padding:  EdgeInsets.only(top:10.0),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              showLoadingDialog();
                              submitUser(email.text, name.text, nickname.text,
                                      telephone.text)
                                  .then((value) {
                                hideLoadingDialog();
                                if (value) {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => MatchesPage(),
                                  ));
                                } else {
                                  _showFlash(
                                      message:
                                          "Error in registration. Please check your data.",
                                      duration: Duration(milliseconds: 3000),
                                      context: context);
                                }
                              });
                            }
                          },
                          child: Text("Finish registration"),
                        )),
                  )
                ]))));
  }
}

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ),
        backgroundColor: Colors.blue,
        // bottomNavigationBar: ,
        body: RegistrationForm());
  }
}

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 50);

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username does not exist';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Lost&Found',
      onLogin: logIn,
      onSignup: register,
      onSubmitAnimationCompleted: () {
        if (GlobalData.userExists) {
          authenticate();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LostItemPage(),
          ));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RegistrationScreen()));
        }
      },
      hideForgotPasswordButton: true,
      onRecoverPassword: _recoverPassword,
    );
  }
}

void _showFlash({
  String message,
  Duration duration,
  BuildContext context,
  flashStyle = FlashStyle.floating,
}) {
  showFlash(
    context: context,
    duration: duration,
    builder: (context, controller) {
      return Flash(
        controller: controller,
        style: flashStyle,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          message: Text(message),
        ),
      );
    },
  );
}
