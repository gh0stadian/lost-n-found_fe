import 'package:flutter/material.dart';
import 'package:lost_and_found_ui/general_widgets.dart';
import 'package:lost_and_found_ui/matches_detail.dart';
import 'package:lost_and_found_ui/text.dart';
import 'models/match.dart';
import 'api_requests/matches.dart';

class MatchesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: CustomTopBar(""),
      backgroundColor: Colors.white,
      bottomNavigationBar: customBottomNavigationBar(0),
      body: ListView(
        children: <Widget>[
          new Heading("Matches"),
          new MatchCol(),
        ],
        // child: new Column(
        //   children: <Widget>[
        //     new Heading("Matches"),
        //     new MatchCol(),
          // ],
        // ),
      ),
    );
  }
}

class MatchCol extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MatchColState();
  }
}

class _MatchColState extends State<MatchCol> {
  List<Match> matches;

  refresh() {
    fetchMatches().then((value) {
      setState(() {
        matches = value;
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
    if (matches != null) {
      return Container(
          height: 800,
          child: ListView.builder(
              itemCount: matches.length,
              physics:  const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return MatchRow(matches[index], refresh);
              }));
    } else {
      return Container(height: 220, child: ListView());
    }
  }
}

class MatchRow extends StatelessWidget {
  MatchRow(this.match, this.refreshCallback);

  Function refreshCallback;
  Match match;

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 220.0,
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 10.0,
        ),
        child: new GestureDetector(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => matchesDetailPage(match)),
              ).then((value) => refreshCallback());
            },
            child: new Stack(
              children: <Widget>[
                MatchCard,
                MatchPercentage(match.percentage),
                MatchThumbnails(),
                ItemTitle(match.lost.title),
              ],
            )));
  }

  final MatchCard = new Container(
    // height: 230.0,
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
}


class MatchThumbnails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.only(top: 55.0),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: new Image(
                image: new AssetImage("assets/img/flower.jpg"),
                // height: 200.0,
                // width: 115,
                fit: BoxFit.contain,
                // fit: BoxFit.fitWidth,
                width: 180.0,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: new Image(
                image: new AssetImage("assets/img/flower.jpg"),
                // width: 115,
                // fit: BoxFit.contain,
                width: 180.0,
              ),
            ),
          ],
        )
    );
  }
}