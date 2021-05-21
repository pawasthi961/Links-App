import 'package:Links/models/user.dart';
import 'package:Links/screens/wrapper.dart';
import 'package:Links/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Links/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              width: 0.0,
              height: 0.0,
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<SignedInUser>.value(
              value: AuthService().user,
              child: MaterialApp(
                home: Wrapper(),
              ),
            );
          }
          return MaterialApp(
            home: SafeArea(
              child: Loading(),
            ),
          );
        });
  }
}
