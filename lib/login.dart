import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'matches.dart';
import 'auth.dart';

const users = const {
  'bobo@bobo.sk': 'bobo',
  'hunter@gmail.com': 'hunter',
};

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
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MatchesPage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}