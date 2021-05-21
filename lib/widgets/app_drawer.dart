import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:Links/services/auth.dart';
import 'package:Links/screens/profile.dart';
import 'package:Links/screens/home.dart';

class AppDrawer extends StatelessWidget {
  final userFirstName;
  final userLastName;
  final userEmail;
  final userAvatarColor;

  AppDrawer(
      {this.userEmail,
      this.userAvatarColor,
      this.userLastName,
      this.userFirstName});

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<SignedInUser>(context);
    final AuthService _auth = AuthService();

    return Theme(
      data: ThemeData.dark().copyWith(canvasColor: Colors.black),
      child: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _createHeader(userFirstName: userFirstName, userEmail: userEmail),
              _createDrawerItem(
                  icon: Icon(
                    Icons.home_filled,
                    // color: Colors.green,
                  ),
                  text: "Home",
                  onTap: (() {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                                  userLastName: userLastName,
                                  userAvatarColor: userAvatarColor,
                                  userFirstName: userFirstName,
                                  userEmail: userEmail,
                                )));
                  })),
              _createDrawerItem(
                  icon: Icon(
                    Icons.favorite,
                    // color: Colors.red,
                  ),
                  text: "Favorites",
                  onTap: (() {})),
              _createDrawerItem(
                  icon: Icon(Icons.info), text: "About", onTap: (() {})),
              _createDrawerItem(
                icon: Icon(Icons.logout),
                text: "Logout",
                onTap: (() async {
                  await _auth.signOut();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _createHeader({String userFirstName, String userEmail}) {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(color: Color(0xFFEB1555)
        // color: Color(0xFF0A0E21),
        ),
    child: Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 10.0, 5.0),
          child: CircleAvatar(
            child: Text(
              userFirstName[0].toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w500),
            ),
            radius: 40.0,
            backgroundColor: Colors.blue,
            // backgroundColor: Color(0xFF0A0E21),
          ),
        ),
        Positioned(
          bottom: 30.0,
          left: 20.0,
          child: Text(
            // "Flutter",
            userFirstName,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          left: 20.0,
          child: Text(
            // "Flutter",
            userEmail,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _createDrawerItem({Icon icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: [
        icon,
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text, style: TextStyle()),
        )
      ],
    ),
    onTap: onTap,
  );
}

// FlatButton.icon(
// onPressed: () async {
// setState(() {
// showSpinner = true;
// });
// await _auth.signOut();
// setState(() {
// showSpinner = false;
// });
// },
// label: Text('logout'),
// icon: Icon(Icons.person),
// ),
