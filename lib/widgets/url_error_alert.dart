import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UrlErrorAlert extends StatelessWidget {
  final linkAddress;
  UrlErrorAlert({this.linkAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                "Alert",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Divider(
          color: Colors.grey,
          height: 4.0,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
          child: Text("Could not lunch link\n"
              "$linkAddress\n\n"
              "Kindly check if the link is valid or not"),
        ),
        Divider(
          color: Colors.grey,
          height: 4.0,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: (() async {
                  Navigator.pop(context);
                }),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Close"),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
