import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_ui/pop_ups/add_new_item_popup.dart';
import 'auth.dart';
import 'detail_page.dart';
import 'text.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'general_widgets.dart';
import 'models/item.dart';
import 'api_requests/items.dart';

class FoundItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: CustomTopBar(""),
      backgroundColor: Colors.white,
      bottomNavigationBar: customBottomNavigationBar(2),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(popUpRoute(createItemPopUp("found")));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          new Heading("Found items"),
          new ItemCol(),
        ],
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
  bool fetched = false;

  refresh() {
    fetchItems('found').then((value) {
      setState(() {
        items = value;
        fetched = true;
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
    if (fetched && items.length != 0) {
      return Container(
        // height: 1200,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              physics:  const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ItemRow(items[index], refresh);
              }
          )
      );
    } else if (fetched && items.length == 0){
      return Container(
        height: 650,
        alignment: Alignment.center,
        // child: Center(
        child: GradientText(
          text: "You dont have any found items",
          colors: <Color>[
            Colors.blue,
            Colors.lightBlue.shade900,
          ],
          style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
        ),
        // )
      );
    }
    else {
      return Container(
          height: 500,
          child: Center(
            child: CircularProgressIndicator(),
          )
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
                MaterialPageRoute(builder: (context) => DetailPage(item, "found")),
              ).then((value) => refreshCallback());
            },
            child: new Stack(
              children: <Widget>[
                ItemCard,
                ItemThumbnail(item),
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

class ItemThumbnail extends StatelessWidget {
  ItemThumbnail(this.item);

  Item item;

  getImage(Item item){
    if (item.images.length == 0) {
      print("Loading asset");
      return AssetImage('assets/img/default.jpg');
    }
    else {
      return NetworkImage(
        'http://${GlobalData.serverAddress}/api/files/download/'
            '${item.id}/${item.images[0]}',
        headers: {'Authorization': GlobalData.jwt},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 40),
      alignment: FractionalOffset.topCenter,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: new Image(
            image: getImage(item),
            // height: 200.0,
            // width: BoxFit.fitWidth,
            fit: BoxFit.contain,
            // width: 92.0,
          )
      ),
    );
  }
}