import 'package:flutter/material.dart';
import 'package:Links/widgets/colors_circular_avatar.dart';

class ColorPallet extends StatelessWidget {
  final Function setParentWidgetColor;
  final Function setParentWidgetColorName;

  ColorPallet({this.setParentWidgetColorName, this.setParentWidgetColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ColorsCircularAvatar(
                  color: 0xffac725e,
                  colorName: "Chocolate Ice cream",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xffd06b64,
                  colorName: "Old brick red",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xfff83a22,
                  colorName: "cardinal",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xfffa573c,
                  colorName: "Wild strawberries",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xffff7537,
                  colorName: "Mars orange",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xffffad46,
                  colorName: "Yellow cab",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ColorsCircularAvatar(
                  color: 0xff42d692,
                  colorName: "Spearmint",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xff16a765,
                  colorName: "Vern fern",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xff7bd148,
                  colorName: "Asparagus",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xffb3dc6c,
                  colorName: "Slime green",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xfffbe983,
                  colorName: "Desert sand",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xfffad165,
                  colorName: "Macaroni",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ColorsCircularAvatar(
                  color: 0xff92e1c0,
                  colorName: "Sea foam",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xff9fe1e7,
                  colorName: "Pool",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xff9fc6e7,
                  colorName: "Denim",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xff4986e7,
                  colorName: "Rainy sky",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xff9a9cff,
                  colorName: "Blue velvet",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xffb99aff,
                  colorName: "Purple dino",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ColorsCircularAvatar(
                  color: 0xff5f6368,
                  colorName: "Mouse",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xffcabdbf,
                  colorName: "Mountain grey",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xffcca6ac,
                  colorName: "Earthworm",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xfff691b2,
                  colorName: "Bubblegum",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xffcd74e6,
                  colorName: "Purple rain",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
                ColorsCircularAvatar(
                  color: 0xffa47ae2,
                  colorName: "Toy eggplant",
                  setParentWidgetColorName: setParentWidgetColorName,
                  setParentWidgetColor: setParentWidgetColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
