import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'text.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'general_widgets.dart';
import 'models/item.dart';
import 'api_requests/items.dart';

class LostItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: CustomTopBar(""),
      backgroundColor: Colors.white,
      // bottomNavigationBar: ,
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Heading("Lost items"),
            new ItemCol(),
          ],
        ),
      ),
    );
  }
}

class ItemCol extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ItemColState();
  }
}

class _ItemColState extends State<ItemCol> {
  List<Item> items;

  refresh() {
    fetchLostItems().then((value) {
      setState(() {
        items = value;
      });
    });
  }

  @override
  initState() {
    super.initState();
    refresh();

  }

  @override
  Widget build(BuildContext context) {
    if (items != null) {
      return Container(
        height: 1200,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemRow(items[index], refresh);
              })
      );
    } else {
      return Container(
        height: 200,
          child: ListView()
      );
    }
  }
}


class ItemRow extends StatelessWidget {
  ItemRow(this.item, this.refreshCallback);
  Function refreshCallback;
  Item item;

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 250.0,
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 10.0,
        ),
        child: new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage(item)),
              ).then((value) => refreshCallback());
            },
            child: new Stack(
              children: <Widget>[
                ItemCard,
                ItemThumbnail,
                ItemTitle(item.title),
              ],
            )));
  }
}

final ItemCard = new Container(
  height: 250.0,
  margin: new EdgeInsets.only(left: 2.0),
  decoration: new BoxDecoration(
    color: new Color(0xFFFFFFFF),
    shape: BoxShape.rectangle,
    borderRadius: new BorderRadius.circular(8.0),
    boxShadow: <BoxShadow>[
      new BoxShadow(
        color: Colors.black12,
        blurRadius: 10.0,
        offset: new Offset(0.0, 10.0),
      ),
    ],
  ),
);

final ItemThumbnail = new Container(
  margin: new EdgeInsets.symmetric(vertical: 0.0),
  alignment: FractionalOffset.topCenter,
  child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: new Image(
        image: new AssetImage("assets/img/flower.jpg"),
        height: 200.0,
        // width: BoxFit.fitWidth,
        // fit: BoxFit.fitWidth,
        // width: 92.0,
      )
  ),
);