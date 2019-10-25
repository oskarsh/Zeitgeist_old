import 'package:flutter/material.dart';
import '../state/appState.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import "../services/database.dart";
import "../model/time.dart";
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List<TimesModel> times = [];

List<TimelineModel> items = [
      TimelineModel(Placeholder(),
          position: TimelineItemPosition.random,
          iconBackground: Colors.redAccent,
          icon: Icon(Icons.blur_circular)),
      TimelineModel(Placeholder(),
          position: TimelineItemPosition.random,
          iconBackground: Colors.redAccent,
          icon: Icon(Icons.blur_circular)),
    ];

  @override
  void initState() { 
    super.initState();
    setTimesFromDB();
  }

  setTimesFromDB() async{
    var fetchedTimes = await TimesDatabaseService.db.getTimesFromDB();
    setState(() {
      times = fetchedTimes;
    });
    print(fetchedTimes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 150,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[Text("ProfilePhoto"), Text("Your Name")],
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 300,
                color: Colors.white,
                child: Timeline(children: items, position: TimelinePosition.Center)
              ),
            ),
          )
        ],
      )),
    );
  }
}
