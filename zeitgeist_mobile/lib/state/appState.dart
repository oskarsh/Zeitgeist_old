//
//
// LICENSE: MIT
// AUTHOR: daeh@tuta.io
// TITLE:
// DESCRIPTION: This Class is used as a global state
//
import 'package:flutter/material.dart';
import 'package:countdown/countdown.dart';
import "../services/database.dart";
import "../model/time.dart";

class AppState with ChangeNotifier {
  Duration resetValue = Duration(minutes: 1);
  Duration duration = Duration(minutes: 1);
  int cancelSecond = 10;
  String displayTime = "05:00";
  bool isRunning = false;
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
    print(d);
    duration = d;
    displayTime = computeDisplayTime();
    isRunning = false;
    notifyListeners();
  }

  onMainTimerFinished() async {
    print("Main timer done");
    TimesModel newTime = new TimesModel(
        title: "no title",
        date: DateTime.now(),
        points: 5,
        timeInMinutes: resetValue.inMinutes);
    var latestTime = await TimesDatabaseService.db.addTimeInDB(newTime);
    print(latestTime);
    resetTimer();
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
