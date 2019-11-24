import 'package:flutter/material.dart';
import '../../state/appState.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import "../../services/database.dart";
import "../../model/time.dart";
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage({Key key}) : super(key: key);

  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
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

  static Widget timeline_element(minutes) {
    String time = computeDisplayTime(Duration(minutes: minutes));
    return Column(children: <Widget>[
      Container(
          color: Colors.white,
          height: 150,
          width: 500,
          child: Container(
            child: Center(
              child: Text(
                "${time}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          )),
      SizedBox(
        height: 8,
      )
    ]);
  }

  buildTimelineModels(times) {
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
    if (items.isEmpty) {
      return Scaffold(
          body: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("looks empty here, start a new Quest!",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      "assets/empty.png",
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )));
    } else {
      return Scaffold(
          body: Container(
        height: 500,
        child: Timeline(children: items, position: TimelinePosition.Left),
      ));
    }
  }
}
