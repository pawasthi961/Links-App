import 'package:flutter/material.dart';
import 'package:Links/services/database.dart';
import 'package:Links/widgets/color_pallet.dart';
// import 'package:Links/services/auth.dart';
import 'package:Links/models/user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  final String userFirstName;
  final String userLastName;
  final String userEmail;
  final int userAvatarColor;

  UpdateProfile(
      {this.userEmail,
      this.userLastName,
      this.userFirstName,
      this.userAvatarColor});

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String currentFirstName;
  String currentLastName;
  int currentColor;
  String currentColorName = "";

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

  void setColorName(String childWidgetColorName) {
    setState(() {
      currentColorName = childWidgetColorName;
    });
  }

  TextEditingController firstNameController;
  TextEditingController lastNameController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.userFirstName);
    lastNameController = TextEditingController(text: widget.userLastName);
    currentColor = widget.userAvatarColor;
  }

  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SignedInUser>(context);
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SingleChildScrollView(
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
                      "Profile",
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
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: "First Name",
                    border: InputBorder.none,
                  ),
                  onChanged: (val) => setState(() => currentFirstName = val),
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
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    border: InputBorder.none,
                  ),
                  onChanged: (val) => setState(() => currentLastName = val),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              // GestureDetector(
              //   onTap: () => _selectDate(context),
              //   child: ListTile(
              //     leading: Padding(
              //         padding: EdgeInsets.only(left: 12.0),
              //         child: Icon(Icons.date_range)),
              //     title: Text(
              //       currentExpiryDate,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 5.0,
              // ),
              // Divider(
              //   color: Colors.grey,
              //   height: 4.0,
              // ),
              // GestureDetector(
              //   onTap: () => _selectTime(context),
              //   child: ListTile(
              //     leading: Padding(
              //         padding: EdgeInsets.only(left: 12.0),
              //         child: Icon(Icons.access_time)),
              //     title: Text(
              //       currentExpiryTime,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 5.0,
              // ),
              // Divider(
              //   color: Colors.grey,
              //   height: 4.0,
              // ),
              GestureDetector(
                onTap: _showColorPallet,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Color(currentColor),
                  ),
                  title: Text(
                    "Selected Color",
                  ),
                  subtitle: Text(currentColorName),
                ),
              ),
              // Divider(
              //   color: Colors.grey,
              //   height: 4.0,
              // ),
              // SizedBox(
              //   height: 5.0,
              // ),
              // ColorPallet(
              //   setParentWidgetColor: setColor,
              //   setParentWidgetColorName: setColorName,
              // ),

              SizedBox(
                height: 5.0,
              ),
              Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 30.0, right: 30.0),
              //   child: TextFormField(
              //     validator: (val) =>
              //         val.isEmpty ? 'Please Enter Link Description' : null,
              //     decoration: InputDecoration(
              //       hintText: "Link Description",
              //       border: InputBorder.none,
              //     ),
              //     maxLines: 4,
              //     onChanged: (val) => setState(() => currentDescription = val),
              //   ),
              // ),
              GestureDetector(
                onTap: (() async {
                  try {
                    if (currentFirstName == null) {
                      setState(() {
                        currentFirstName = widget.userFirstName;
                      });
                    }
                    if (currentColor == null) {
                      setState(() {
                        currentColor = widget.userAvatarColor;
                      });
                    }
                    if (currentLastName == null) {
                      setState(() {
                        currentLastName = widget.userLastName;
                      });
                    }
                    await DatabaseService().updateUserData(
                        userId: user.uid,
                        firstName: currentFirstName,
                        lastName: currentLastName,
                        email: widget.userEmail,
                        profileAvatarColor: currentColor);
                  } catch (e) {
                    print(e);
                  }

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
      ),
    );
  }
}
