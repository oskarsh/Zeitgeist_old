import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import '../state/appState.dart';
import 'package:provider/provider.dart';
import 'package:countdown/countdown.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import "../services/database.dart";


class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  double _lowerValue = 0;
  double _upperValue;
  // value for animation
  double value = 5;
  IconData _iconData = Icons.play_arrow;
  String _labelData = "Play";
  var abortTimer;
  final FlareControls controls = FlareControls();
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressFloatingButton() {
    final state = Provider.of<AppState>(context);
    print(state.isRunning);
    if (state.isRunning) {
      if (_labelData == "surrender") {
        _showDialog();
      }
      state.cancelTimer();
      abortTimer.cancel();
      _controller.reverse();
      setState(() {
        _iconData = Icons.play_arrow;
        _labelData = "Play";
      });
    } else {
      _controller.forward();
      state.startTimer();
      CountDown cancelCountDown = CountDown(Duration(seconds: 10));
      var cancelTimer = cancelCountDown.stream.listen(null);
      cancelTimer.onDone(() {
        setState(() {
          _labelData = "surrender";
        });
      });
      cancelTimer.onData((Duration d) {
        setState(() {
          _labelData = "cancel (${d.inSeconds})";
        });
      });
      setState(() {
        abortTimer = cancelTimer;
      });
    }
    // check if the timer is running and set the cancel icon
    state.isRunning
        ? setState(() {
            _iconData = Icons.cancel;
          })
        : null;
  }

// user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Do you really want to surrender?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("yes"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: new Icon(_iconData),
        label: new Text(_labelData),
        onPressed: _onPressFloatingButton,
        shape: new BeveledRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
      ),
      body: Container(
          color: Colors.transparent,
          // Add box decoration
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[Text("Coins: 5", style: TextStyle(color: Colors.white))],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(width: 75),
                    Column(
                      children: <Widget>[
                        Text(
                          state.displayTime,
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.white),
                        ),
                        SizedBox(
                          height: 200,
                        ),
                        AnimatedBuilder(
                          animation: _controller,
                          child: Container(
                            height: 200,
                            width: 200,
                            child: FlareActor(
                              'assets/ghost_animation.flr',
                              animation: 'idle',
                              fit: BoxFit.contain,
                              controller: controls,
                            ),
                          ),
                          builder: (BuildContext context, Widget child) {
                            return Transform.translate(
                              offset: state.isRunning ? Offset(0, 50) : Offset(_controller.value * 1300, 0),
                              child: child,
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      width: 75,
                      height: 500,
                      child: FlutterSlider(
                        values: [state.duration.inMinutes.toDouble()],
                        max: 120,
                        min: 0,
                        step: 5,
                        axis: Axis.vertical,
                        rtl: true,
                        onDragging: (handlerIndex, lowerValue, upperValue) {
                          _lowerValue = lowerValue;
                          _upperValue = upperValue;
                          state.setMinutes(_lowerValue.round());
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ]))),
    );
  }
}
