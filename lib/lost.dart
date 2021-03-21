import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Api classes.dart';

Widget lostItemWidget() {
  return FutureBuilder(
    builder: (context, itemSnap){
      if (itemSnap.connectionState == ConnectionState.none &&
          itemSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      return ListView.builder(
          itemCount: itemSnap.data.length,
          itemBuilder: (context, index) {
            Item item = itemSnap.data[index];
            return Card(
              elevation: 5,
            );
          }
      );
    },
    future: fetchLostItems(),
  );
}

class LostScreen extends StatelessWidget {
  static const title = 'Lost items';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        // body: Container (
        // // appBar: AppBar(title: Text('ListViews')),
        //   child: Column (
        //     mainAxisSize: MainAxisSize.max,
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: <Widget>[
        //       Expanded(
        //           child: lostItemWidget()
        //       )
        //     ]
        //   )
        // ),
      ),
    );
  }
}