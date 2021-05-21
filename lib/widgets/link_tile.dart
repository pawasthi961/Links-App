import 'package:Links/services/validate_url.dart';
import 'package:flutter/material.dart';
import 'package:Links/widgets/view_link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Links/widgets/url_error_alert.dart';

class LinkTile extends StatelessWidget {
  final linkName;
  final linkColor;
  final currentLinkId;
  final linkAddress;
  final linkExpiryDate;
  final linkExpiryTime;
  final linkDescription;
  final parentFolderId;
  final linkColorName;
  LinkTile(
      {this.linkName,
      this.linkColor,
      this.currentLinkId,
      this.linkAddress,
      this.linkExpiryDate,
      this.linkExpiryTime,
      this.linkDescription,
      this.parentFolderId,
      this.linkColorName});

  @override
  Widget build(BuildContext context) {
    void showErrorDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.dark(),
              child: AlertDialog(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                    width: 400.0,
                    child: UrlErrorAlert(linkAddress: linkAddress)),
              ),
            );
          });
    }

    void _showViewLinkDetails() {
      showDialog(
          useSafeArea: true,
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.dark(),
              child: AlertDialog(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                    width: 400.0,
                    child: ViewLink(
                      linkName: linkName,
                      linkColor: linkColor,
                      linkColorName: linkColorName,
                      parentFolderId: parentFolderId,
                      linkAddress: linkAddress,
                      linkDescription: linkDescription,
                      linkExpiryDate: linkExpiryDate,
                      linkExpiryTime: linkExpiryTime,
                      currentLinkId: currentLinkId,
                    )),
              ),
            );
          });
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: (() async {
          if (await canLaunch(ValidateURL(url: linkAddress).validateUrl())) {
            await launch(ValidateURL(url: linkAddress).validateUrl());
          } else {
            showErrorDialog();
          }
        }),
        onLongPress: (() {
          _showViewLinkDetails();
        }),
        child: Card(
          color: Color(linkColor),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black87,
              radius: 20.0,
              child: Icon(Icons.link, color: Colors.white),
            ),
            title: Text(
              linkName,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "PlayfairDisplay",
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onPressed: (() {
                _showViewLinkDetails();
              }),
            ),
          ),
        ),
      ),
    );
  }
}
