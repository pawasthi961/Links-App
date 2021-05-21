import 'package:Links/widgets/share.dart';
import 'package:flutter/material.dart';
import 'package:Links/widgets/edit_link.dart';
import 'package:Links/widgets/delete_link.dart';

class ViewLink extends StatefulWidget {
  final linkName;
  final linkColor;
  final currentLinkId;
  final linkAddress;
  final linkExpiryDate;
  final linkExpiryTime;
  final linkDescription;
  final parentFolderId;
  final linkColorName;

  ViewLink({
    this.currentLinkId,
    this.linkName,
    this.parentFolderId,
    this.linkColor,
    this.linkColorName,
    this.linkDescription,
    this.linkExpiryTime,
    this.linkExpiryDate,
    this.linkAddress,
  });

  @override
  _ViewLinkState createState() => _ViewLinkState();
}

class _ViewLinkState extends State<ViewLink> {
  @override
  Widget build(BuildContext context) {
    void _showDelete() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.dark(),
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  content: Container(
                      width: 400.0,
                      // height: 180.0,
                      child: DeleteLink(
                        currentLinkId: widget.currentLinkId,
                      ))),
            );
          });
    }

    void _showShareDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.dark(),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                    width: 400.0,
                    child: ShareLink(
                      address: widget.linkAddress,
                      description: widget.linkDescription,
                    )),
              ),
            );
          });
    }

    void _showEditLink() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.dark(),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  width: 400.0,
                  child: EditLink(
                    linkName: widget.linkName,
                    linkColor: widget.linkColor,
                    linkColorName: widget.linkColorName,
                    parentFolderId: widget.parentFolderId,
                    linkAddress: widget.linkAddress,
                    linkExpiryDate: widget.linkExpiryDate,
                    linkExpiryTime: widget.linkExpiryTime,
                    currentLinkId: widget.currentLinkId,
                    linkDescription: widget.linkDescription,
                  ),
                ),
              ),
            );
          });
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  "Link Details",
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
            child: Text(widget.linkName),
          ),
          Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
            child: Text(widget.linkAddress),
          ),
          Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Color(widget.linkColor),
              ),
              title: Text(
                widget.linkColorName,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: ListTile(
              leading: Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Icon(Icons.access_time)),
              title: Text(
                widget.linkExpiryTime,
              ),
              subtitle: Text(
                "HH:MM AM/PM",
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: ListTile(
              leading: Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Icon(Icons.date_range)),
              title: Text(
                widget.linkExpiryDate,
              ),
              subtitle: Text(
                "YYYY-MM-DD",
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
            child: Text(widget.linkDescription),
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
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: (() {}),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (() {
                    _showEditLink();
                  }),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: (() {
                    _showShareDialog();
                  }),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  onPressed: (() {
                    _showDelete();
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
