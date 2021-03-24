import 'package:flutter/material.dart';
import 'api_requests/items.dart';
import 'login.dart';
import 'detail_page.dart';
import 'lost_item.dart';
import 'dart:async';


void main() {
  funcThatMakesAsyncCall();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost&Found',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LostItemPage(),
    );
  }
}

Future funcThatMakesAsyncCall() async {
  var result = await fetchLostItems();
  print(result);
}
