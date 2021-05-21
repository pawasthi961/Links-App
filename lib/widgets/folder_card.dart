import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Links/widgets/view_folder.dart';
import 'package:Links/screens/folder_display.dart';

class FolderCard extends StatelessWidget {
  final color;
  final name;
  final parentFolderId;
  final currentId;
  final description;
  final colorName;
  final String userFirstName;
  final String userLastName;
  final int userAvatarColor;
  final String userEmail;
  FolderCard({
    this.parentFolderId,
    this.currentId,
    this.name,
    this.color,
    this.description,
    this.colorName,
    this.userAvatarColor,
    this.userEmail,
    this.userFirstName,
    this.userLastName,
  });
  @override
  Widget build(BuildContext context) {
    void _showViewFolderDetails() {
      showDialog(
          useSafeArea: true,
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
                  child: ViewFolder(
                      folderName: name,
                      folderColor: color,
                      folderDescription: description,
                      folderCurrentId: currentId,
                      parentFolderId: parentFolderId,
                      folderColorName: colorName),
                ),
              ),
            );
          });
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FolderDisplay(
              userEmail: userEmail,
              userFirstName: userFirstName,
              userLastName: userLastName,
              userAvatarColor: userAvatarColor,
              currentRootFolderId: currentId,
              currentRootFolderName: name,
            ),
          ),
        );
      },
      onLongPress: () {
        _showViewFolderDetails();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 0.0,
          color: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: FittedBox(
                    child: Icon(
                      Icons.folder,
                      color: Color(color),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0.0),
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                            fontFamily: "PlayfairDisplay", fontSize: 17.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
