import 'package:flutter/material.dart';
import 'package:lost_and_found_ui/api_requests/items.dart';
import 'package:lost_and_found_ui/found_item.dart';
import 'lost_item.dart';
import 'matches/matches.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/item.dart';

class CustomTopBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  CustomTopBar(
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      bottomOpacity: 0.0,
      title: Text(
        title,
        style: TextStyle(color: Colors.blue),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      
    );
  }
}


class detailTopBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  Item item;
  String itemType;

  detailTopBar(this.item, this.itemType)  : preferredSize = Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      bottomOpacity: 0.0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.delete, color: Colors.black),
            onPressed: () => deleteItem(item, itemType).then((value) =>
                Navigator.of(context).pop())),
      ],

    );
  }
}

class matchesTopBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  String phoneNumber;

  matchesTopBar(
    this.phoneNumber, {
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  _makePhoneCall(String number) async {
    String url = "tel:" + number;
    // const url = 'tel:9876543210';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  _writeSms(String number) async {
    String url = "sms:" + number;
    // const url = 'tel:9876543210';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      bottomOpacity: 0.0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.sms,
            color: Colors.black,
          ),
          onPressed: () => _writeSms(phoneNumber),
        ),
        IconButton(
          icon: Icon(
            Icons.call,
            color: Colors.black,
          ),
          onPressed: () => _makePhoneCall(phoneNumber),
        )
      ],
    );
  }
}

class customBottomNavigationBar extends StatefulWidget {
  int index;
  customBottomNavigationBar(this.index);
  @override
  _NavigationBarState createState() => _NavigationBarState(index);
}

class _NavigationBarState extends State<customBottomNavigationBar> {
  int _selectedIndex;
  _NavigationBarState(this._selectedIndex);
  static List<Widget> _widgetOptions = <Widget>[
    MatchesPage(),
    LostItemPage(),
    FoundItemPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _widgetOptions[index]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.loop_outlined),
          label: 'Matches',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.find_in_page_outlined),
          label: 'Your lost items',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.find_replace_rounded),
          label: 'Your found items',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}

