import 'package:flutter/material.dart';
import "../../services/database.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key key}) : super(key: key);

  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int minutes = 0;
  int points = 0;
  int streak = 0;
  // Create storage
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    setPointsFromdB();
    setTimesCountFromDB();
    setStreakFromStorage();
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

  setStreakFromStorage() async {
    String streakCounter = await storage.read(key: "streak_counter");
    print("streak");
    print(streakCounter);
    setState(() {
      streak = int.parse(streakCounter);
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
        child: ListView(padding: EdgeInsets.all(10), children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Container(
                height: 170,
                margin: const EdgeInsets.only(top: 30.0),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(10)),
                  color: Colors.blue,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: new Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("current streak",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("${streak} Days",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40)),
                    ),
                  ]),
                )),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                buildItem("Overall Time", minutes, "minutes"),
                buildItem("Points", points, "points"),
                buildItem("Running streak", streak, "Days"),
                buildItem("Quests finished", 14, "Quests"),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
