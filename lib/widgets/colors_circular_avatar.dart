import 'package:flutter/material.dart';

class ColorsCircularAvatar extends StatefulWidget {
  final int color;
  final String colorName;

  final Function setParentWidgetColorName;

  final Function setParentWidgetColor;

  ColorsCircularAvatar(
      {this.color,
      this.colorName,
      this.setParentWidgetColor,
      this.setParentWidgetColorName});

  @override
  _ColorsCircularAvatarState createState() => _ColorsCircularAvatarState();
}

class _ColorsCircularAvatarState extends State<ColorsCircularAvatar> {
  int currentColor;
  String currentColorName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        setState(() {
          currentColor = widget.color;
          currentColorName = widget.colorName;
        });
        widget.setParentWidgetColor(currentColor);
        widget.setParentWidgetColorName(currentColorName);
        Navigator.pop(context);
      }),
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: 20.0,
          backgroundColor: Color(widget.color),
        ),
      ),
    );
  }
}
