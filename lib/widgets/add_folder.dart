import 'package:flutter/material.dart';
import 'package:Links/services/database.dart';
import 'package:Links/widgets/color_pallet.dart';
import 'package:Links/widgets/loading.dart';

class AddFolder extends StatefulWidget {
  final String currentId;
  AddFolder({this.currentId});

  @override
  _AddFolderState createState() => _AddFolderState();
}

class _AddFolderState extends State<AddFolder> {
  final _formKey = GlobalKey<FormState>();

  String currentName = "";
  String currentColorName = "White";
  int currentColor = 0xffffffff;
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

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                          "Folder",
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
                      decoration: InputDecoration(
                        hintText: "Folder Name",
                        border: InputBorder.none,
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Please Enter Folder Name' : null,
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
                        backgroundColor: Color(currentColor),
                      ),
                      title: Text(
                        "Selected Folder Color",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(currentColorName),
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
                      validator: (val) => val.isEmpty
                          ? 'Please Enter Folder Description'
                          : null,
                      decoration: InputDecoration(
                        hintText: "Folder Description",
                        border: InputBorder.none,
                      ),
                      maxLines: 4,
                      onChanged: (val) =>
                          setState(() => currentDescription = val),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        try {
                          await DatabaseService().addFolder(
                              name: currentName,
                              color: currentColor,
                              description: currentDescription,
                              parentFolderId: widget.currentId,
                              colorName: currentColorName);
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          loading = false;
                        });
                        // print(currentColorName);
                        // print(currentColor);
                        // print(widget.currentId);
                        // print(currentName);
                        // print(currentDescription);
                        Navigator.pop(context);
                      }
                    }),
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFEB1555),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Add Folder",
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

// return Form(
//   key: _formKey,
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     mainAxisSize: MainAxisSize.min,
//     children: <Widget>[
//       Text(
//         "Add a folder",
//         style: TextStyle(fontSize: 18.0),
//       ),
//       SizedBox(height: 20.0),
//       TextFormField(
//         decoration: InputDecoration(
//           hintText: "Folder Name",
//         ),
//         validator: (val) => val.isEmpty ? 'please Enter folder Name' : null,
//         onChanged: (val) => setState(() => _currentName = val),
//       ),
//       SizedBox(height: 20.0),
//       //dropDown
//       DropdownButtonFormField(
//         hint: Text("Select Color"),
//         items: colors.map((color) {
//           return DropdownMenuItem(
//             value: color,
//             child: Text(
//               color,
//               style: TextStyle(
//                 color: Color(
//                   colorsCode[color],
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//         onChanged: ((val) {
//           setState(() {
//             _currentColor = colorsCode[val];
//           });
//         }),
//       ),
//       //slider
//
//       // RaisedButton(
//       //   color: Colors.lightBlue,
//       //   child: Text('Add'),
//       //   onPressed: () async {
//       //     try {
//       //       DatabaseService().addFolder(
//       //           name: _currentName,
//       //           color: _currentColor,
//       //           parentFolderId: widget.currentId);
//       //     } catch (e) {
//       //       print(e);
//       //     }
//       //   },
//       // ),
//       InkWell(
//         child: Container(
//           padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
//           decoration: BoxDecoration(
//             color: Color(0xff00bfa5),
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(32.0),
//                 bottomRight: Radius.circular(32.0)),
//           ),
//           child: Text(
//             "Rate Product",
//             style: TextStyle(color: Colors.white),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     ],
//   ),
// );
