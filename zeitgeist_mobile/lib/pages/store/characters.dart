import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import '../../model/character.dart';

class CharacterShop extends StatefulWidget {
  CharacterShop({Key key}) : super(key: key);

  _CharacterShopState createState() => _CharacterShopState();
}

class _CharacterShopState extends State<CharacterShop> {
  List<Character> characters = [];
  int currIdx;

  @override
  void initState() {
    super.initState();
    var json = loadAsset();
    loadCharacters(json);
  }

  loadAsset() {
    return DefaultAssetBundle.of(context).loadString('assets/characters.json');
  }

  void loadCharacters(json) {
    json.then((value) {
      print(value);
      List<dynamic> charactersMap = jsonDecode(value);

      List<Character> chs = [];
      for (var i in charactersMap) {
        print(i);
        chs.add(Character(i["name"], i["price"], i["image_path"]));
      }
      setState(() {
        characters = chs;
      });
    });
  }

  void buyItem() {
    print("Item bought");
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
          onPressed: buyItem,
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
            items: characters.map((character) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                              padding: EdgeInsets.all(70),
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(8.0),
                                child: Image.asset(
                                  character.image_path,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text(character.name,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40)),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("${character.price}",
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
