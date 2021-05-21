import 'package:flutter/material.dart';
import 'package:Links/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:Links/widgets/rounded_button.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // text field state
  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";
  String error = "";
  bool showSpinner = false;
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Color(0xFFEB1555),
          elevation: 0.0,
          title: Text('Sign Up'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person, color: Colors.white),
              label: Text("Sign In", style: TextStyle(color: Colors.white)),
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
                  keyboardType: TextInputType.text,
                  validator: (val) =>
                      val.isEmpty ? "Enter Your First Name" : null,
                  onChanged: (val) {
                    setState(() {
                      firstName = val;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "FirstName",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (val) =>
                      val.isEmpty ? "Enter Your Last Name" : null,
                  onChanged: (val) {
                    setState(() {
                      lastName = val;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Last Name",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) => val.isEmpty ? "Enter an Email" : null,
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
                        borderRadius: BorderRadius.circular(32.0)),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter a password " : null,
                  obscureText: showPassword,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                RoundedButton(
                  function: () async {
                    setState(() {
                      error = "";
                      showSpinner = true;
                    });
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerUser(
                          email: email,
                          password: password,
                          firstName: firstName,
                          lastName: lastName);
                      if (result == null) {
                        setState(() {
                          error = 'please supply a valid email';
                        });
                      } else if (result == "email-already-in-use") {
                        setState(() {
                          error = 'The account already exists for that email.';
                        });
                      } else if (result == "weak-password") {
                        setState(() {
                          error = "The password provided is too weak.";
                        });
                      } else {
                        setState(() {
                          error = null;
                        });
                        print(result);
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                  color: Color(0xFFEB1555),
                  title: "Register",
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
