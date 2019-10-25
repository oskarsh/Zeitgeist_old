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
  List<TimelineModel> items = [];

  // List<TimelineModel> items = [
  //   TimelineModel(timeline_element(),
  //       position: TimelineItemPosition.right,
  //       iconBackground: Colors.redAccent,
  //       icon: Icon(Icons.blur_circular)),
  //   TimelineModel(timeline_element(),
  //       position: TimelineItemPosition.right,
  //       iconBackground: Colors.redAccent,
  //       icon: Icon(Icons.blur_circular)),
  // ];

  static Widget timeline_element(minutes) {
    print("model of timeline");
    return Column(children: <Widget>[
      Container(
        color: Colors.white,
        height: 150,
        width: 500,
        child: Text("${minutes}"),
      ),
      SizedBox(
        height: 8,
      )
    ]);
  }

  buildTimelineModels(times) {
    print("build timeline");
    List<TimelineModel> timelineModels = [];
    for (var time in times) {
      print(time.timeInMinutes);
      timelineModels.add(TimelineModel(timeline_element(time.timeInMinutes),
          position: TimelineItemPosition.right,
          iconBackground: Colors.redAccent,
          icon: Icon(Icons.blur_circular)));
    }
    setState(() {
      items = timelineModels;
    });
    print(timelineModels);
  }

  @override
  void initState() {
    super.initState();
    setTimesFromDB();
  }

  setTimesFromDB() async {
    var fetchedTimes = await TimesDatabaseService.db.getTimesFromDB();
    buildTimelineModels(fetchedTimes);
    print(fetchedTimes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Timeline(children: items, position: TimelinePosition.Left)),
    );
  }
}
