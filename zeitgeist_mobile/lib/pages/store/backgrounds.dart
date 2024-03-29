import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../model/background.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:zeitgeist_mobile/state/appState.dart';
import 'package:provider/provider.dart';

class BackgroundShop extends StatefulWidget {
  final AppState state;

  BackgroundShop({Key key, this.state}) : super(key: key);

  _BackgroundShopState createState() => _BackgroundShopState();
}

class _BackgroundShopState extends State<BackgroundShop> {
  List<Background> backgrounds = [];
  int currIdx = 0;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
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

      List<Background> bgs = [];
      for (var i in backgroundsMap) {
        print(i);
        bgs.add(Background(i["name"], i["price"], i["image_path"]));
      }
      setState(() {
        backgrounds = bgs;
      });
    });
  }

  void nextPage(id) {
    print(id);
    setState(() {
      currIdx = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: new Text("GET"),
          onPressed: () async {
            int price = backgrounds[currIdx].price;
            String storageStreak = await storage.read(key: "streak");
            int streak = int.parse(storageStreak);

            if (streak >= price) {
              showDialog(
                context: context,
                builder: (BuildContext context) => FancyDialog(
                    title: "Buy Background?",
                    descreption: "",
                    okFun: () {
                      String bgImage =
                          backgrounds[currIdx].image_path.toString();
                      print("WRITE $bgImage");
                      widget.state.setCurrentBG(bgImage);
                      storage.write(key: "background", value: bgImage);
                    }),
              );
            } else {
              print("pop context");
            }
          },
          shape: new BeveledRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: CarouselSlider(
            onPageChanged: nextPage,
            initialPage: 0,
            viewportFraction: 1.0,
            height: MediaQuery.of(context).size.height * 0.95,
            items: backgrounds.map((background) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(8.0),
                              child: Image.asset(
                                background.image_path,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width * 0.9,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(background.name,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40)),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("${background.price}",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          )
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
