import 'package:Links/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Links/widgets/link_tile.dart';

final linksDatabaseReference = FirebaseFirestore.instance.collection("links");

class LinksStream extends StatelessWidget {
  final currentFolderId;
  LinksStream({this.currentFolderId});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: linksDatabaseReference
          .where('parentFolderId', isEqualTo: currentFolderId)
          .orderBy('linkName', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        final links = snapshot.data.docs;

        List<LinkTile> linkTiles = [];
        for (var link in links) {
          final parentFolderId = link.data()['parentFolderId'];
          final linkAddress = link.data()['linkAddress'] ?? "";
          final linkExpiryDate = link.data()['linkExpiryDate'] ?? "";
          final linkExpiryTime = link.data()['linkExpiryTime'] ?? "";
          final linkDescription = link.data()['linkDescription'] ?? "";
          final linkColorName = link.data()["linkColorName"] ?? "";
          final linkName = link.data()['linkName'] ?? "";
          final linkColor = link.data()['linkColor'] ?? "";
          final currentLinkId = link.id;

          final linkTile = LinkTile(
              linkName: linkName,
              linkDescription: linkDescription,
              linkColor: linkColor,
              linkColorName: linkColorName ?? "",
              linkExpiryTime: linkExpiryTime,
              linkExpiryDate: linkExpiryDate,
              linkAddress: linkAddress,
              currentLinkId: currentLinkId,
              parentFolderId: parentFolderId);
          linkTiles.add(linkTile);
        }

        return ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: linkTiles,
        );
      },
    );
  }
}
