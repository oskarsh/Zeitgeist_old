//
//
// LICENSE: MIT
// AUTHOR: daeh@tuta.io
// TITLE:
// DESCRIPTION: This Class is used as a global state
//
import 'package:flutter/material.dart';
import 'package:countdown/countdown.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "../services/database.dart";
import "../model/time.dart";

class AppState with ChangeNotifier {
  // Create storage
  final storage = new FlutterSecureStorage();
  Duration resetValue = Duration(minutes: 1);
  Duration duration = Duration(minutes: 1);
  int cancelSecond = 10;
  String displayTime = "05:00";
  bool isRunning = false;
  bool isFinished = false;
  var mainTimer;

  void setMinutes(minutes) {
    duration = Duration(minutes: minutes);
    // save the duration for resetting the timer
    resetValue = Duration(minutes: minutes);
    displayTime = computeDisplayTime();
    notifyListeners();
  }

  void resetTimer() {
    duration = resetValue;
    displayTime = computeDisplayTime();
    notifyListeners();
  }

  void setSeconds(seconds) {
    duration = Duration(seconds: seconds);
    displayTime = computeDisplayTime();
    notifyListeners();
  }

  startTimer() {
    // creating the timers
    CountDown countDown = CountDown(duration);
    mainTimer = countDown.stream.listen(null);

    // REGISTER CALLBACKS
    mainTimer.onData(onMainTimerData);
    mainTimer.onDone(onMainTimerFinished);

    // set global timer running to true
    isRunning = true;
    notifyListeners();
  }

  onMainTimerData(Duration d) {
    duration = d;
    displayTime = computeDisplayTime();
    notifyListeners();
  }

  onMainTimerFinished() async {
    print("Main timer done");
    TimesModel newTime = new TimesModel(
        title: "no title",
        date: DateTime.now(),
        points: calculatePoints(resetValue.inMinutes),
        timeInMinutes: resetValue.inMinutes);
    var latestTime = await TimesDatabaseService.db.addTimeInDB(newTime);
    calculateStreak(latestTime);
    print(latestTime);
    resetTimer();
    isRunning = false;
    isFinished = true;
    notifyListeners();
  }

  calculateStreak(latestTime) async {
    // this will calculate the current streak
    // Read value
    String tempDate = await storage.read(key: "lastDate");
    DateTime currentDate = latestTime.date;
    // check if the last date is null, should just happen if it is the first time
    if (tempDate == null) {
      storage.write(key: "lastDate", value: currentDate.toIso8601String());
      storage.write(key: "streak", value: 1.toString());
    } else {
      String tempCounter = await storage.read(key: "streak");
      // if there is no streak counter default it to 1
      if (tempCounter == null) {
        storage.write(key: "streak", value: 1.toString());
        tempCounter = "1";
      }
      // convert counter to int
      int counter = int.parse(tempCounter);

      // get the time when the counter was last incremented
      DateTime lastIncrement = DateTime.parse(tempDate);

      print("difference");
      var difference = lastIncrement.difference(currentDate).inDays;

      if (difference == 0) {
        print("added +1 to streak");
        counter++;
        await storage.write(key: "streak", value: counter.toString());
      }
      if (difference >= 1) {
        // reset counter
        counter = 0;
        await storage.write(key: "streak", value: counter.toString());
      }
      print(counter);
    }
  }

  int calculatePoints(int time) {
    var points = time * 0.3;
    return points.floor();
  }

  cancelTimer() {
    mainTimer.cancel();
    isRunning = false;
    resetTimer();
  }

  String computeDisplayTime() {
    String twoDigitMinutes = twoDigits(duration.inMinutes);
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}
