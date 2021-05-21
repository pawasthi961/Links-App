import 'package:flutter/material.dart';
import 'file:///C:/Users/Prakhar/AndroidStudioProjects/Links/lib/screens/folder_display.dart';

class FolderTile extends StatelessWidget {
  final name;
  final color;
  final currentId;
  FolderTile({this.name, this.color, this.currentId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: (() {
          // Provider.of<DatabaseService>(context)
          //     .updateId(folder.data().);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FolderDisplay(
                        currentRootFolderId: currentId,
                      )));
        }),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Color(color),
            ),
            title: Text(name),
          ),
        ),
      ),
    );
  }
}
