// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:links_app/models/folder.dart';
// import 'package:links_app/services/database.dart';
// import 'package:provider/provider.dart';
// import 'package:links_app/screens/home/folder_tile.dart';
//
// class FolderList extends StatefulWidget {
//   @override
//   _FolderListState createState() => _FolderListState();
// }
//
// class _FolderListState extends State<FolderList> {
//   String uid() {
//     return Provider.of<DatabaseService>(context).uid;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final folders = Provider.of<List<Folder>>(context);
//     // print(folders.docs);
//     // for (var doc in folders.docs) {
//     //   print(doc.data());
//     // }
//     print(uid());
//     List<Folder> filteredFolders;
//     folders.forEach((folder) {
//       if (folder.parentFolderId == "uid") {
//         filteredFolders.add(folder);
//       }
//     });
//
//     filteredFolders.forEach((folder) {
//       print(folder.parentFolderId);
//       print(folder.currentFolderId);
//       print(folder.name);
//       print(folder.color);
//     });
//     return ListView.builder(
//       itemCount: folders.length,
//       itemBuilder: (context, index) {
//         return FolderTile(folder: folders[index]);
//       },
//     );
//     return Container();
//   }
// }
