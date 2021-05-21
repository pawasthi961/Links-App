import 'package:flutter/material.dart';
import 'package:Links/services/database.dart';
import 'package:Links/widgets/color_pallet.dart';
import 'package:Links/widgets/loading.dart';

class EditFolder extends StatefulWidget {
  final String currentFolderId;
  final String name;
  final String parentFolderId;
  final String description;
  final int color;
  final String colorName;
  EditFolder({
    this.currentFolderId,
    this.colorName,
    this.name,
    this.parentFolderId,
    this.description,
    this.color,
  });

  @override
  _EditFolderState createState() => _EditFolderState();
}

class _EditFolderState extends State<EditFolder> {
  String currentName;
  String currentColorName;
  int currentColor;
  String currentDescription;
  void _showColorPallet() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.dark(),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              content: Container(
                width: 400.0,
                child: ColorPallet(
                  setParentWidgetColor: setColor,
                  setParentWidgetColorName: setColorName,
                ),
              ),
            ),
          );
        });
  }

  void setColor(int childWidgetColor) {
    setState(() {
      currentColor = childWidgetColor;
    });
  }

  void setColorName(String childWidgetColorName) {
    setState(() {
      currentColorName = childWidgetColorName;
    });
  }

  TextEditingController _folderNameController;
  TextEditingController _folderDescriptionController;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _folderNameController = TextEditingController(text: widget.name);
    _folderDescriptionController =
        TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SingleChildScrollView(
            child: Form(
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
                          "Edit Folder",
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
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextFormField(
                      controller: _folderNameController,
                      decoration: InputDecoration(
                        hintText: "Enter folder name",
                        border: InputBorder.none,
                      ),
                      onChanged: (val) => setState(() => currentName = val),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  GestureDetector(
                    onTap: _showColorPallet,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Color(currentColor ?? widget.color),
                      ),
                      title: Text(
                        "Selected Folder Color",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(currentColorName ?? widget.colorName),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextFormField(
                      controller: _folderDescriptionController,
                      decoration: InputDecoration(
                        hintText: "Enter folder description",
                        border: InputBorder.none,
                      ),
                      maxLines: 4,
                      onChanged: (val) =>
                          setState(() => currentDescription = val),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      try {
                        setState(() {
                          loading = true;
                        });
                        await DatabaseService().updateFolderData(
                            name: currentName ?? widget.name,
                            color: currentColor ?? widget.color,
                            description:
                                currentDescription ?? widget.description,
                            parentFolderId: widget.parentFolderId,
                            currentFolderId: widget.currentFolderId,
                            colorName: currentColorName ?? widget.colorName);
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // print(currentColorName);
                      // print(currentColor);
                      // print(widget.currentFolderId);
                      // print(currentName);
                      // print(currentDescription);
                    }),
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFEB1555),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0),
                          ),
                        ),
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
