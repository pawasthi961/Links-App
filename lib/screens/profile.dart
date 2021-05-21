import 'package:Links/services/database.dart';
import 'package:Links/widgets/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:Links/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:Links/models/user.dart';

class Profile extends StatelessWidget {
  final String userFirstName;
  final String userLastName;
  final int userAvatarColor;
  final String userEmail;

  Profile(
      {this.userEmail,
      this.userFirstName,
      this.userAvatarColor,
      this.userLastName});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SignedInUser>(context);
    void _showLinkAddBox() {
      showDialog(
          useSafeArea: true,
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.dark(),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                    width: 400.0,
                    child: UpdateProfile(
                      userAvatarColor: userAvatarColor,
                      userLastName: userLastName,
                      userFirstName: userFirstName,
                      userEmail: userEmail,
                    )),
              ),
            );
          });
    }

    return Theme(
      data: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black, primaryColor: Colors.black),
      child: SafeArea(
        child: Scaffold(
          drawer: AppDrawer(
            userAvatarColor: userAvatarColor,
            userEmail: userEmail,
            userFirstName: userFirstName,
            userLastName: userLastName,
          ),
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: (() async {
                  await DatabaseService().updateUserData(
                      userId: user.uid,
                      lastName: "email",
                      firstName: "Testing",
                      profileAvatarColor: 4288668135,
                      email: "testingemail2@email.com");
                }),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            title: Text("Profile"),
            backgroundColor: Color(0xFFEB1555),
          ),
          body: Container(
            margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CircleAvatar(
                    radius: 80.0,
                    child: Text(userFirstName[0].toUpperCase(),
                        style: TextStyle(
                            fontSize: 100.0,
                            color: Colors.white,
                            fontFamily: "PlayfairDisplay")),
                    backgroundColor: Color(userAvatarColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 40.0),
                    child: Center(
                      child: Text(
                        "${userFirstName} ${userLastName}",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "PlayfairDisplay"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Email Address",
                        style:
                            TextStyle(color: Color(0xFFEB1555), fontSize: 14.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        userEmail,
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: "PlayfairDisplay"),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
