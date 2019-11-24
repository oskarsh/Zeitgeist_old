import 'package:flutter/material.dart';
import '../../state/appState.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import "../../services/database.dart";
import "../../model/time.dart";
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key key}) : super(key: key);

  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int minutes = 0;
  int points = 0;

  @override
  void initState() {
    super.initState();
    setPointsFromdB();
    setTimesCountFromDB();
    setStreakFromDB();
  }

  setStreakFromDB() async {
    var fetchedDate = await TimesDatabaseService.db.getLastDateTimeFromDB();
    print(fetchedDate);
  }

  setPointsFromdB() async {
    var fetchedPoints = await TimesDatabaseService.db.getPointsFromDB();
    setState(() {
      points = fetchedPoints;
    });
  }

  setTimesCountFromDB() async {
    var fetchedTimes =
        await TimesDatabaseService.db.getTimesCountInMinutesFromDB();
    setState(() {
      minutes = fetchedTimes;
    });
  }

  buildItem(title, value, type) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: new Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$title",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("$value",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$type"),
            )
          ],
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Container(
                height: 150,
                margin: const EdgeInsets.only(top: 30.0),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(10)),
                  color: Colors.blue,
                ),
                child: Text("red")),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                buildItem("Overall Time", minutes, "minutes"),
                buildItem("Points", points, "points"),
                buildItem("Running streak", 3, "Days"),
                buildItem("Quests finished", 14, "Quests"),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
