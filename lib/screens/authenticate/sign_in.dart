import 'package:Links/widgets/forgot_password_alert.dart';
import 'package:flutter/material.dart';
import 'package:Links/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:Links/widgets/rounded_button.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final FirebaseAuth authPasswordReset = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  // text field state
  String email = "";
  String password = "";
  String error = "";
  bool showSpinner = false;
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    void _showPasswordResetDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.dark(),
              child: AlertDialog(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                    width: 400.0, child: ForgotPasswordAlert(email: email)),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Color(0xFFEB1555),
          elevation: 0.0,
          title: Text('Sign In'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
            )
          ]),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? "Enter Email Address" : null,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email Address",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Password" : null,
                  obscureText: showPassword,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () => setState(() {
                          showPassword = !showPassword;
                        }),
                      )),
                ),
                SizedBox(height: 20.0),
                RoundedButton(
                    function: () async {
                      setState(() {
                        error = "";
                        showSpinner = true;
                      });
                      if (_formKey.currentState.validate()) {
                        dynamic result =
                            await _auth.signInUser(email, password);
                        if (result == null) {
                          setState(() {
                            error = " Enter valid email address";
                          });
                        } else if (result == 'user-not-found') {
                          setState(() {
                            error = "No user found for that email.";
                          });
                        } else if (result == 'wrong-password') {
                          setState(() {
                            error = "Wrong password provided for that user.";
                          });
                        } else {
                          print("printing from signIn page ${result.uid}");
                        }
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                    color: Color(0xFFEB1555),
                    title: "Sign In"),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: (() async {
                    await authPasswordReset
                        .sendPasswordResetEmail(email: email)
                        .then((value) {
                      _showPasswordResetDialog();
                    }).catchError((e) {
                      print(e);
                    });
                  }),
                  child: Center(
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(color: Colors.blue, fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
