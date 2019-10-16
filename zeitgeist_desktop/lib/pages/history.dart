import 'package:flutter/material.dart';
import '../state/appState.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    return Container(
       child: Text("hello"),
    );
  }
}