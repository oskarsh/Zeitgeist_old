import 'package:flutter/material.dart';
import "pages/timer.dart";
import "pages/profile.dart";
import "pages/history.dart";
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'state/appState.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  App({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  bool showIcons = true;
  int _selectedTab = 1;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _pageOptions = [HistoryPage(), TimerPage(), ProfilePage()];

  void startAnimation() {
    _controller.forward(from: 0);
  }

  Widget renderApp() {
    final state = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(color: Colors.transparent ,child: _pageOptions[_selectedTab]),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: !state.isRunning
            ? new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                      icon: new Icon(FeatherIcons.home),
                      color:
                          _selectedTab == 0 ? Colors.blue : Colors.grey,
                      onPressed: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      }),
                  IconButton(
                      icon: Icon(Icons.timer),
                      color:
                          _selectedTab == 1 ? Colors.blueAccent : Colors.grey,
                      onPressed: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      }),
                  IconButton(
                      icon: Icon(FeatherIcons.user),
                      color:
                          _selectedTab == 2 ? Colors.blueAccent : Colors.grey,
                      onPressed: () {
                        setState(() {
                          _selectedTab = 2;
                        });
                      })
                ],
              )
            : new Row(
                children: <Widget>[
                  SizedBox(
                    height: 48,
                  )
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _selectedTab == 1 ? Stack(
      children: <Widget>[
        new Container(
          height: double.infinity,
          width: double.infinity,
          decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/forest.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        renderApp()
      ],
    ) : renderApp();
  }
}
