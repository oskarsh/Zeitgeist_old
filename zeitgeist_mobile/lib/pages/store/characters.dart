import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CharacterShop extends StatefulWidget {
  CharacterShop({Key key}) : super(key: key);

  _CharacterShopState createState() => _CharacterShopState();
}

class _CharacterShopState extends State<CharacterShop> {
  List<String> images = [
    "assets/images/Characters/cyberpunk-street.png",
    "assets/images/Characters/magic-cliffs.png",
    "assets/images/Characters/underwater.png",
  ];

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
            items: images.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Column(
                        
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
