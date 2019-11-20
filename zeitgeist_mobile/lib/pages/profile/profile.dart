import 'package:flutter/material.dart';
import '../../state/appState.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import "../../services/database.dart";
import "../../model/time.dart";
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import "./timeline.dart";
import "./statistics.dart";

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<TimelineModel> items = [];

  @override
  void initState() {
    super.initState();
    setTimesFromDB();
  }

  setTimesFromDB() async {
    var fetchedTimes = await TimesDatabaseService.db.getTimesFromDB();
    print(fetchedTimes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(150.0),
                      child: AppBar(
                        title: Row(
                          children: <Widget>[
                            Image.asset("assets/ghost.png", fit: BoxFit.cover),
                            Text("Zeitgeist")
                          ],
                        ),
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {
                              print("settings");
                            },
                          )
                        ],
                        bottom: TabBar(
                          tabs: <Widget>[
                            Tab(text: "Statistics"),
                            Tab(text: "Timeline")
                          ],
                        ),
                      ),
                    ),
                    body: TabBarView(
                      children: <Widget>[
                        StatisticsPage(),
                        TimelinePage()
                      ],
                    ),
                  )))),
    );
  }
}
