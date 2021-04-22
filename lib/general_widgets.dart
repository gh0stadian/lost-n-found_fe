import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Matches',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Your items',
          backgroundColor: Colors.red,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
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
