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


  static String computeDisplayTime(duration) {
    String twoDigitMinutes = twoDigits(duration.inMinutes);
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  static String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

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
    String time = computeDisplayTime(Duration(minutes: minutes));
    return Column(children: <Widget>[
      Container(
        color: Colors.white,
        height: 150,
        width: 500,
        child: Container(
          child: Center(child: Text("${time}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),),
        )
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
          child: Column(children: <Widget>[
            Container(
              height: 150,
              margin: const EdgeInsets.only(top: 30.0),
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(10)),
                color: Colors.red,

              ),
              child: Text("Red")),

            Container(
              height: 500,
              child: Timeline(children: items, position: TimelinePosition.Left),
            )
          ]),
          ),
    );
  }
}
