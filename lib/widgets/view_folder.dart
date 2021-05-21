import 'package:Links/widgets/edit_folder.dart';
import 'package:flutter/material.dart';
import 'package:Links/services/database.dart';
import 'package:Links/widgets/color_pallet.dart';
import 'package:Links/widgets/delete_folder.dart';

class ViewFolder extends StatefulWidget {
  final String folderCurrentId;
  final String folderName;
  final int folderColor;
  final String folderDescription;
  final String parentFolderId;
  final String folderColorName;

  ViewFolder({
    this.folderCurrentId,
    this.folderName,
    this.parentFolderId,
    this.folderColor,
    this.folderColorName,
    this.folderDescription,
  });

  @override
  _ViewFolderState createState() => _ViewFolderState();
}

class _ViewFolderState extends State<ViewFolder> {
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
                      child: DeleteFolder(
                        folderCurrentId: widget.folderCurrentId,
                      ))),
            );
          });
    }

    void _showEditFolder() {
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
                  child: EditFolder(
                    name: widget.folderName,
                    color: widget.folderColor,
                    colorName: widget.folderColorName,
                    parentFolderId: widget.parentFolderId,
                    currentFolderId: widget.folderCurrentId,
                    description: widget.folderDescription,
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
                  "Folder Details",
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
            child: Text(widget.folderName),
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
                backgroundColor: Color(widget.folderColor),
              ),
              title: Text(
                widget.folderColorName,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
            child: Text(widget.folderDescription),
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
                    icon: Icon(Icons.edit),
                    onPressed: (() {
                      _showEditFolder();
                    })),
                // VerticalDivider(
                //   thickness: 1,
                //   width: 4.0,
                //   color: Colors.grey,
                // ),
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
