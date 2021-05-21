import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Links/services/database.dart';
import 'package:Links/widgets/loading.dart';

class DeleteFolder extends StatefulWidget {
  final folderCurrentId;
  DeleteFolder({this.folderCurrentId});

  @override
  _DeleteFolderState createState() => _DeleteFolderState();
}

class _DeleteFolderState extends State<DeleteFolder> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Column(
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
                      "Delete Folder",
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
                child: Text("Are you sure you want to delete this Folder?\n"
                    "This action cannot be undone"),
              ),
              Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (() {
                        Navigator.pop(context);
                      }),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Cancel"),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      width: 4.0,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: (() async {
                        try {
                          setState(() {
                            loading = true;
                          });
                          await DatabaseService().deleteFolder(
                              currentFolderId: widget.folderCurrentId);
                        } catch (e) {
                          print("error in deleting $e");
                        }
                        setState(() {
                          loading = false;
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Delete"),
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
