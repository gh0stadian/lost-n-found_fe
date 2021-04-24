import 'dart:ui';

import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_ui/api_requests/items.dart';
import 'package:lost_and_found_ui/api_requests/matches.dart';
import 'package:lost_and_found_ui/api_requests/metadata.dart';
import 'package:lost_and_found_ui/matches/matches.dart';
import 'package:lost_and_found_ui/models/match.dart';
import 'package:lost_and_found_ui/models/item.dart';
import '../text.dart';

class confirmationPopUp extends StatefulWidget {
  Match match;
  String type;

  confirmationPopUp(this.match, this.type);



  @override
  State<StatefulWidget> createState() => _confirmationPopUpState(match, type);
  // State<StatefulWidget> createState() => _confirmationPopUpState();
}

class _confirmationPopUpState extends State<confirmationPopUp> {
  Match match;
  String type;

  _confirmationPopUpState(this.match, this.type);

  update() {
    updateMatch(match).then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MatchesPage()));
    });
  }

  @override
  initState() {
    super.initState();
    if (type == "resolve"){
      match.status = "resolved";
    }
    else {
      match.status = "canceled match";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          decoration:
              new BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            // contentPadding: EdgeInsets.only(top: 10.0, left: 40, right: 40),
            content: Container(
                height: 80,
                margin: new EdgeInsets.only(top: 40.0),
                child: Center(
                  child: GradientText(
                    text: "Are you sure ?",
                    colors: [
                      Colors.redAccent,
                      Colors.deepPurpleAccent,
                    ],
                  ),
                )),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              MaterialButton(
                elevation: 5.0,
                child: Text("Yes"),
                onPressed: () {
                  print("SAVING");
                  update();
                  // return Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => MatchesPage()));
                },
              ),
            ],
          ),
        ));
  }
}
