import 'package:flutter/material.dart';
import 'package:Links/services/database.dart';
import 'package:Links/widgets/color_pallet.dart';
import 'package:Links/widgets/loading.dart';

class EditLink extends StatefulWidget {
  final linkName;
  final linkColor;
  final currentLinkId;
  final linkAddress;
  final linkExpiryDate;
  final linkExpiryTime;
  final linkDescription;
  final parentFolderId;
  final linkColorName;

  EditLink({
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
  _EditLinkState createState() => _EditLinkState();
}

class _EditLinkState extends State<EditLink> {
  String currentName;
  String currentColorName;
  int currentColor;
  String currentExpiryDate;
  String currentExpiryTime;
  String currentDescription;
  String currentAddress;

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
          data: ThemeData.dark().copyWith(dialogBackgroundColor: Colors.black),
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

  TextEditingController _linkNameController;
  TextEditingController _linkAddressController;
  TextEditingController _linkDescriptionController;

  bool loading = false;
  @override
  void initState() {
    _linkNameController = TextEditingController(text: widget.linkName);
    _linkAddressController = TextEditingController(text: widget.linkAddress);
    _linkDescriptionController =
        TextEditingController(text: widget.linkDescription);

    super.initState();
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
                          "Edit Link",
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
                      controller: _linkNameController,
                      decoration: InputDecoration(
                        hintText: "Enter link title",
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
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextFormField(
                      controller: _linkAddressController,
                      decoration: InputDecoration(
                        hintText: "Enter link address",
                        border: InputBorder.none,
                      ),
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
                        currentExpiryDate ?? widget.linkExpiryDate,
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
                        currentExpiryTime ?? widget.linkExpiryTime,
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
                        backgroundColor:
                            Color(currentColor ?? widget.linkColor),
                      ),
                      title: Text(
                        "Selected Link Color",
                      ),
                      subtitle: Text(currentColorName ?? widget.linkColorName),
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
                      controller: _linkDescriptionController,
                      decoration: InputDecoration(
                        hintText: "Enter link description",
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
                        await DatabaseService().updateLinkData(
                          linkId: widget.currentLinkId,
                          linkColorName:
                              currentColorName ?? widget.linkColorName,
                          linkName: currentName ?? widget.linkName,
                          linkColor: currentColor ?? widget.linkColor,
                          parentFolderId: widget.parentFolderId,
                          linkAddress: currentAddress ?? widget.linkAddress,
                          linkDescription:
                              currentDescription ?? widget.linkDescription,
                          linkExpiryDate:
                              currentExpiryDate ?? widget.linkExpiryDate,
                          linkExpiryTime:
                              currentExpiryTime ?? widget.linkExpiryTime,
                        );
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
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
