import 'package:flutter/material.dart';
import 'package:Links/services/database.dart';
import 'package:Links/widgets/color_pallet.dart';
import 'package:Links/widgets/loading.dart';

class AddLink extends StatefulWidget {
  final String currentId;
  AddLink({this.currentId});

  @override
  _AddLinkState createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  final _formKey = GlobalKey<FormState>();

  String currentName = "";
  String currentColorName = "White";
  int currentColor = 0xffffffff;
  String currentExpiryDate;
  String currentExpiryTime;
  String currentDescription = "";
  String currentAddress = "";

  void setColor(int childWidgetColor) {
    setState(() {
      currentColor = childWidgetColor;
    });
  }

  void _showColorPallet() {
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
      },
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      cancelText: "Cancel",
      confirmText: "Confirm",
    );
    if (picked != null && picked.toString() != currentExpiryDate) {
      setState(() {
        currentExpiryDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
      initialTime: TimeOfDay(hour: 00, minute: 00),
    );
    if (newTime != null) {
      setState(() {
        currentExpiryTime = "${newTime.format(context)}";
      });
    }
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
                          "Link",
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
                  Flexible(
                    child: Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Link Name",
                        border: InputBorder.none,
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Please Enter Link Name' : null,
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
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Copy Link Address",
                        border: InputBorder.none,
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Please Enter Link Address' : null,
                      onChanged: (val) => setState(() => currentAddress = val),
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
                    onTap: () => _selectDate(context),
                    child: ListTile(
                      leading: Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Icon(Icons.date_range)),
                      title: Text(
                        currentExpiryDate ?? "Select Link Expiry Date",
                      ),
                      subtitle: Text(
                        "YYYY-MM-DD",
                        style: TextStyle(fontSize: 12.0),
                      ),
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
                    onTap: () => _selectTime(context),
                    child: ListTile(
                      leading: Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Icon(Icons.access_time)),
                      title: Text(
                        currentExpiryTime ?? "Select link Expiry Time",
                      ),
                      subtitle: Text(
                        "HH:MM AM/PM",
                        style: TextStyle(fontSize: 12.0),
                      ),
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
                        "Selected Link Color",
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
                      validator: (val) =>
                          val.isEmpty ? 'Please Enter Link Description' : null,
                      decoration: InputDecoration(
                        hintText: "Link Description",
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
                        try {
                          setState(() {
                            loading = true;
                          });
                          await DatabaseService().addLink(
                            linkName: currentName,
                            linkColor: currentColor,
                            linkColorName: currentColorName,
                            parentFolderId: widget.currentId,
                            linkAddress: currentAddress,
                            linkDescription: currentDescription,
                            linkExpiryDate: currentExpiryDate ?? "____/__/__",
                            linkExpiryTime: currentExpiryTime ?? "__:__ __",
                          );
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          loading = false;
                        });
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
                          "Add Link",
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
