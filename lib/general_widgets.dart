import 'package:flutter/material.dart';
import 'package:lost_and_found_ui/api_requests/items.dart';
import 'package:lost_and_found_ui/found_item.dart';
import 'package:lost_and_found_ui/login.dart';
import 'auth.dart';
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
    LoginScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 3){
        GlobalData.jwt = null;
        GlobalData.uid = null;
        GlobalData.userExists = false;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _widgetOptions[index]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: TextStyle(color: Colors.black),

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.compare_arrows_rounded),
          backgroundColor: Colors.white,
          label: 'Matches',
          // backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_search_rounded),
          backgroundColor: Colors.white,
          label: 'Lost items',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory),
          backgroundColor: Colors.white,
          label: 'Found items',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          backgroundColor: Colors.blue,
          label: 'Log out',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}

