import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final String title;
  final String asset;
  final Function onPress;

  const ShopCard({
    Key key,
    @required this.title,
    @required this.asset,
    @required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onPress,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 110,
            padding: EdgeInsets.all(15.0),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/${asset}",
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10,10,2,2),
                    width:MediaQuery.of(context).size.width * 0.5,
                    child: Center(child: Text(title),),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
