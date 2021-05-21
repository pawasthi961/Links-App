import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final folderDatabaseReference =
      FirebaseFirestore.instance.collection("folders");
  final usersDatabaseReference = FirebaseFirestore.instance.collection("users");
  final linksDatabaseReference = FirebaseFirestore.instance.collection("links");

  Future<void> addFolder({
    String name,
    int color,
    String colorName,
    String parentFolderId,
    String description,
  }) async {
    DocumentReference ref = await folderDatabaseReference.add({
      "name": name ?? "",
      "color": color ?? 0xffffffff,
      "parentFolderId": parentFolderId,
      "description": description ?? "",
      "colorName": colorName ?? ""
    }).then((value) {
      print(value);
      print("Folder Added");
    }).catchError((error) {
      print("Failed to add : $error");
    });
    print(ref.id);
  }

  // Future<String> getUser(String currentUserId) async {
  //   await usersDatabaseReference
  //       .doc(currentUserId)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     return documentSnapshot.data()["firstName"];
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  Future<void> addLink({
    String linkName,
    String linkAddress,
    int linkColor,
    String linkColorName,
    String linkDescription,
    String linkExpiryDate,
    String linkExpiryTime,
    String parentFolderId,
  }) async {
    DocumentReference ref = await linksDatabaseReference.add({
      'linkName': linkName ?? "",
      'linkAddress': linkAddress ?? "",
      'linkColor': linkColor ?? 0xffffffff,
      'linkDescription': linkDescription ?? "",
      'linkExpiryDate': linkExpiryDate ?? "",
      'linkExpiryTime': linkExpiryTime ?? "",
      'parentFolderId': parentFolderId ?? "",
      'linkColorName': linkColorName ?? "",
    }).then((value) {
      print(value);
      print("Link added");
    }).catchError((error) {
      print("Failed to add Link $error");
    });
    print(ref.id);
  }

  Future<void> addUser(
      {String firstName,
      String lastName,
      String email,
      String userId,
      int profileAvatarColor}) async {
    DocumentReference ref = await usersDatabaseReference.doc(userId).set({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "userId": userId,
      "profileAvatarColor": profileAvatarColor ?? 0xff40c4ff,
    }).then((value) {
      print("User Added");
    }).catchError((error) {
      print("Failed to add : $error");
    });
    print(ref.id);
  }

  Future<void> updateLinkData({
    String linkName,
    String linkAddress,
    int linkColor,
    String linkColorName,
    String linkDescription,
    String linkExpiryDate,
    String linkExpiryTime,
    String linkId,
    String parentFolderId,
  }) async {
    return await linksDatabaseReference.doc(linkId).set(({
          "linkName": linkName,
          "linkAddress": linkAddress,
          "linkColor": linkColor,
          "linkDescription": linkDescription,
          "linkExpiryDate": linkExpiryDate,
          "linkExpiryTime": linkExpiryTime,
          "parentFolderId": parentFolderId,
          "linkColorName": linkColorName,
        }));
  }

  Future<void> updateFolderData({
    String name,
    int color,
    String parentFolderId,
    String description,
    String currentFolderId,
    String colorName,
  }) async {
    return await folderDatabaseReference.doc(currentFolderId).set(({
          "name": name,
          "color": color,
          "description": description,
          "parentFolderId": parentFolderId,
          "colorName": colorName
        }));
  }

  Future<void> updateUserData({
    String firstName,
    String lastName,
    String email,
    String userId,
    int profileAvatarColor,
  }) async {
    return await usersDatabaseReference.doc(userId).set(({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "userId": userId,
          "profileAvatarColor": profileAvatarColor ?? 0xff40c4ff,
        }));
  }

  Future<void> deleteFolder({String currentFolderId}) {
    return folderDatabaseReference
        .doc(currentFolderId)
        .delete()
        .then((value) => print("Folder Deleted"))
        .catchError((error) => print("Failed to delete folder: $error"));
  }

  Future<void> deleteLink({String currentLinkId}) {
    return linksDatabaseReference
        .doc(currentLinkId)
        .delete()
        .then((value) => print("Link Deleted"))
        .catchError((error) => print("Failed to delete link: $error"));
  }

// String uid;
//
// //collection reference
// final CollectionReference folderCollection =
//     FirebaseFirestore.instance.collection('folders');
// Future updateUserData(String name, int color) async {
//   return await folderCollection.doc(uid).set({
//     'name': name,
//     'color': color,
//   });
// }

  //folder list from snapshot
  // List<Folder> _folderListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     var docId = doc.id;
  //     var color = doc.data()['color'];
  //     return Folder(
  //       name: doc.data()['name'] ?? '',
  //       color: color ?? 0xffffffff,
  //       parentFolderId: doc.data()['parentFolderId'],
  //       currentFolderId: docId,
  //     );
  //   }).toList();
  // }

  //user data from snapshot
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: uid,
  //       name: snapshot.data()['name'],
  //       color: snapshot.data()['color']);
  // }

  //get folders stream
  // Stream<List<Folder>> get folders {
  //   return folderCollection
  //       .where('parentFolderId', isEqualTo: uid)
  //       .snapshots()
  //       .map(_folderListFromSnapshot);
  // }

  // Stream<UserData> get userData {
  //   return folderCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  // }

  //adding new folder to the folders collection
  // Future addFolder(String name, int color, String parentFolderId) async {
  //   return folderCollection.add({
  //     'name': name,
  //     'color': color,
  //     'parentFolderId': parentFolderId
  //   }).then((value) {
  //     print("user added");
  //     print(value);
  //   }).catchError((error) {
  //     print("failed to add user : $error");
  //   });
  // }

  // void updateId(String id) {
  //   uid = id;
  //   print("current database uid is $uid");
  //   notifyListeners();
  // }
}
