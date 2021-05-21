import 'package:Links/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Links/widgets/folder_card.dart';

final folderDatabaseReference =
    FirebaseFirestore.instance.collection("folders");

class FoldersStream extends StatelessWidget {
  final currentFolderId;
  final String userFirstName;
  final String userLastName;
  final int userAvatarColor;
  final String userEmail;

  FoldersStream(
      {this.userAvatarColor,
      this.userEmail,
      this.userFirstName,
      this.userLastName,
      this.currentFolderId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: folderDatabaseReference
          .where('parentFolderId', isEqualTo: currentFolderId)
          .orderBy('name', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        final folders = snapshot.data.docs;

        List<FolderCard> folderCards = [];
        for (var folder in folders) {
          final parentFolderId = folder.data()['parentFolderId'];
          final description = folder.data()['description'] ?? "";
          final colorName = folder.data()['colorName'] ?? "";
          final name = folder.data()['name'];
          final color = folder.data()['color'];
          final currentId = folder.id;

          final folderCard = FolderCard(
            userEmail: userEmail,
            userFirstName: userFirstName,
            userLastName: userLastName,
            userAvatarColor: userAvatarColor,
            name: name,
            color: color,
            currentId: currentId,
            description: description,
            parentFolderId: parentFolderId,
            colorName: colorName,
          );
          folderCards.add(folderCard);
        }

        return GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 2,
          children: folderCards,
        );
      },
    );
  }
}
