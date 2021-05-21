import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Links/streams/folders_stream.dart';
import 'package:Links/streams/links_stream.dart';
import 'package:Links/widgets/app_drawer.dart';
import 'package:Links/widgets/fancy_fab.dart';

class FolderDisplay extends StatelessWidget {
  final String currentRootFolderId;
  final String currentRootFolderName;
  final String userFirstName;
  final String userLastName;
  final int userAvatarColor;
  final String userEmail;

  FolderDisplay(
      {this.userAvatarColor,
      this.userEmail,
      this.userFirstName,
      this.userLastName,
      this.currentRootFolderId,
      this.currentRootFolderName});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      child: SafeArea(
        child: Scaffold(
          drawer: AppDrawer(
            userAvatarColor: userAvatarColor,
            userEmail: userEmail,
            userFirstName: userFirstName,
            userLastName: userLastName,
          ),
          floatingActionButton: FancyFab(
            currentRootFolderId: currentRootFolderId,
          ),
          appBar: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            title: Text(currentRootFolderName),
            backgroundColor: Color(0xFFEB1555),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                LinksStream(
                  currentFolderId: currentRootFolderId,
                ),
                SizedBox(
                  height: 5.0,
                ),
                FoldersStream(
                    userAvatarColor: userAvatarColor,
                    userLastName: userLastName,
                    userEmail: userEmail,
                    userFirstName: userFirstName,
                    currentFolderId: currentRootFolderId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
