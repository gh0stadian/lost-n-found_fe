import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:load/load.dart';
import 'lost_item.dart';
import 'matches/matches.dart';
import 'auth.dart';
import 'package:flash/flash.dart';
import 'general_widgets.dart';

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

  @override
  void initState() {
    super.initState();
  }

  double padding = 10.0;
  double edgeRadius = 15.0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: EdgeInsets.all(8),
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
            child: new Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextField(
                    controller: email,
                    decoration: new InputDecoration(
                      labelText: 'Email',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(edgeRadius),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextField(
                    controller: name,
                    decoration: new InputDecoration(
                      labelText: 'Full name',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(edgeRadius),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextField(
                    controller: nickname,
                    decoration: new InputDecoration(
                      labelText: 'Nickname',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(edgeRadius),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextField(
                    controller: telephone,
                    decoration: new InputDecoration(
                      labelText: 'Telephone number',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(edgeRadius),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () {
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
                    },
                    child: Text("Finish registration"),
                  ))
            ])));
  }
}

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: CustomTopBar("Registration"),
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
