import 'package:flutter/material.dart';
import '../state/appState.dart';
import 'package:provider/provider.dart';
import '../components/shopCard.dart';
import "./store/backgrounds.dart";
import "./store/characters.dart";
import 'package:flutter/cupertino.dart';

class ShopPage extends StatefulWidget {
  ShopPage({Key key}) : super(key: key);

  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    return Scaffold(
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ShopCard(
              title: "Characters",
              asset: "ghost.png",
              onPress: (() {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => CharacterShop()));
              }),
            ),
            ShopCard(
              title: "Backgrounds",
              asset: "image_frame.png",
              onPress: (() {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => BackgroundShop()));
              }),
            ),
          ],
        ),
      )),
    );
  }
}
