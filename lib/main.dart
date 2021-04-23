import 'package:flutter/material.dart';
import 'package:lost_and_found_ui/pop_ups/edit_info.dart';
import 'api_requests/items.dart';
import 'login.dart';
import 'detail_page.dart';
import 'lost_item.dart';
import 'dart:async';
import 'matches/matches.dart';
import 'pop_ups/edit_info.dart';
import 'google_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// TODO UNCOMMENT
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:google_map_location_picker/generated/l10n.dart'
//     as location_picker;
import 'package:load/load.dart';

void main() {
  runApp(LoadingProvider(
    child: MyApp(),
    themeData: LoadingThemeData(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        // TODO UNCOMMENT
        // location_picker.S.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
      ],
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
      home: LoginScreen(),
      // home: LostItemPage(),
      // home: MatchesPage(),
    );
  }
}
