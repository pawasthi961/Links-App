import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Links/streams/links_stream.dart';
import 'package:provider/provider.dart';
import 'package:Links/models/user.dart';
import 'package:Links/streams/folders_stream.dart';
import 'package:Links/widgets/app_drawer.dart';
import 'package:Links/widgets/fancy_fab.dart';

class Home extends StatelessWidget {
  final String userFirstName;
  final String userLastName;
  final int userAvatarColor;
  final String userEmail;

  Home({
    this.userAvatarColor,
    this.userEmail,
    this.userFirstName,
    this.userLastName,
  });
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SignedInUser>(context);
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Color(0xFF0A0E21),
          drawer: AppDrawer(
            userAvatarColor: userAvatarColor,
            userEmail: userEmail,
            userFirstName: userFirstName,
            userLastName: userLastName,
          ),
          floatingActionButton: FancyFab(
            currentRootFolderId: user.uid,
          ),
          appBar: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            title: Text('Home'),
            backgroundColor: Color(0xFFEB1555),
            elevation: 0.0,
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                LinksStream(
                  currentFolderId: user.uid,
                ),
                SizedBox(
                  height: 5.0,
                ),
                FoldersStream(
                    userEmail: userEmail,
                    userLastName: userLastName,
                    userFirstName: userFirstName,
                    userAvatarColor: userAvatarColor,
                    currentFolderId: user.uid),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
