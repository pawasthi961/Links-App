import 'package:Links/models/user.dart';
import 'package:Links/screens/authenticate/authenticate.dart';
import 'package:Links/widgets/loading.dart';
import 'package:Links/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userDatabaseReference = FirebaseFirestore.instance.collection("users");

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either the Home or Authenticate widget
    final user = Provider.of<SignedInUser>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return StreamBuilder(
          stream: userDatabaseReference
              .where("userId", isEqualTo: user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            }

            final currentUser = snapshot.data.docs[0];
            final userFirstName = currentUser.data()["firstName"];
            final userLastName = currentUser.data()["lastName"];
            final userEmail = currentUser.data()["email"];
            final userAvatarColor = currentUser.data()["profileAvatarColor"];

            return Home(
              userAvatarColor: userAvatarColor,
              userEmail: userEmail,
              userFirstName: userFirstName,
              userLastName: userLastName,
            );
          });

      // return Home();
    }
  }
}
