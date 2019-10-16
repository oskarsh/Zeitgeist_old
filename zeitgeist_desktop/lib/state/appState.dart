//
//
// LICENSE: MIT
// AUTHOR: daeh@tuta.io
// TITLE:
// DESCRIPTION: This Class is used as a global state
//
import 'package:flutter/material.dart';
import 'package:countdown/countdown.dart';

class AppState with ChangeNotifier {
  Duration resetValue;
  Duration duration = Duration(minutes: 0);
  int cancelSecond = 10;
  String displayTime = "00:00";
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
    notifyListeners();
  }

  onMainTimerFinished() {
    print("Main timer done");
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
