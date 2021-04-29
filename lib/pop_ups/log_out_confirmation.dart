import 'dart:ui';

import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_ui/api_requests/items.dart';
import 'package:lost_and_found_ui/api_requests/metadata.dart';
import 'package:lost_and_found_ui/login.dart';
import 'package:lost_and_found_ui/models/item.dart';
import '../auth.dart';
import '../text.dart';

class LogOutConfirmationPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          decoration:
          new BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: EdgeInsets.only(top: 20.0, left: 40, right: 40),
            content: Container(
              width: 400,
              height: 200,
              child: Center(
                child: GradientText(
                text: "Are you sure you want to log out ?",
                colors: <Color>[
                  Colors.blue,
                  Colors.lightBlue.shade900,
                ],
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text("Yes"),
                onPressed: () {
                  GlobalData.jwt = null;
                  GlobalData.uid = null;
                  GlobalData.userExists = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
