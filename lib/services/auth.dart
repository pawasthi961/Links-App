import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Links/models/user.dart';
import 'package:Links/services/database.dart';
import 'package:provider/provider.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on FirebaseUser
  SignedInUser _userFromFirebase(User user) {
    return user != null ? SignedInUser(uid: user.uid) : null;
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // auth change user stream
  Stream<SignedInUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //sign in with email and password
  Future signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "user-not-found";
      } else if (e.code == 'wrong-password') {
        return 'wrong-password';
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerUser(
      {String email,
      String password,
      String firstName,
      String lastName}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      //create a new document for the user with the uid
      // await DatabaseService(uid: user.uid)
      //     .updateUserData("default name", 0xffffffff);
      await DatabaseService().addUser(
          firstName: firstName,
          lastName: lastName,
          email: email,
          userId: user.uid);
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "weak-password";
      } else if (e.code == 'email-already-in-use') {
        return "email-already-in-use";
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
