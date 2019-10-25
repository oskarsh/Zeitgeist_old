import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import '../../model/background.dart';

class BackgroundShop extends StatefulWidget {
  BackgroundShop({Key key}) : super(key: key);

  _BackgroundShopState createState() => _BackgroundShopState();
}

class _BackgroundShopState extends State<BackgroundShop> {
  List<String> images = [
    "assets/images/backgrounds/cyberpunk-street.png",
    "assets/images/backgrounds/magic-cliffs.png",
    "assets/images/backgrounds/underwater.png",
  ];

  List<Background> backgrounds = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var json = loadAsset();
    loadBackgrounds(json);
  }

  loadAsset() {
    return DefaultAssetBundle.of(context).loadString('assets/backgrounds.json');
  }

  void loadBackgrounds(json) {

    json.then((value) {
      List<dynamic> backgroundsMap = jsonDecode(value);
      backgroundsMap.map((background){
        Background newBg = new Background(background.name, background.price, background.image_path);
        backgrounds.add(newBg);
      });
    });
  }

  void buyItem() {
    print("Item bought");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: new Text("GET"),
          onPressed: buyItem,
          shape: new BeveledRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: CarouselSlider(
            viewportFraction: 1.0,
            height: MediaQuery.of(context).size.height * 0.95,
            items: backgrounds.map((background) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            background.image_path,
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width * 0.9,
                            fit: BoxFit.cover,
                          ),
                          Text(background.name),
                          Text("${background.price}")
                        ],
                      ));
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
