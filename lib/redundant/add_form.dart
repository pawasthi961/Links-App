// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:links_app/screens/home/home.dart';
// import 'package:links_app/services/database.dart';
// import "package:provider/provider.dart";
//
// class AddForm extends StatefulWidget {
//   @override
//   _AddFormState createState() => _AddFormState();
// }
//
// class _AddFormState extends State<AddForm> {
//   String provideId() {
//     // return Provider.of<DatabaseService>(context).uid;
//   }
//
//   final _formKey = GlobalKey<FormState>();
//   final List<String> colors = [
//     'white',
//     'red',
//     'pink',
//     'orange',
//     'amber',
//     'brown',
//     'blue',
//   ];
//   final Map<String, int> colorsCode = {
//     "white": 0xffffffff,
//     "red": 0xfff44336,
//     "pink": 0xffe91e63,
//     "orange": 0xffff9800,
//     "amber": 0xffff6f00,
//     "brown": 0xff795548,
//     "blue": 0xff2196f3
//   };
//
//   String _currentName;
//   int _currentColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           Text(
//             "Add a folder",
//             style: TextStyle(fontSize: 18.0),
//           ),
//           SizedBox(height: 20.0),
//           TextFormField(
//             decoration: InputDecoration(
//               hintText: "Folder Name",
//             ),
//             validator: (val) => val.isEmpty ? 'please Enter folder Name' : null,
//             onChanged: (val) => setState(() => _currentName = val),
//           ),
//           SizedBox(height: 20.0),
//           //dropDown
//           DropdownButtonFormField(
//             hint: Text("Select Color"),
//             items: colors.map((color) {
//               return DropdownMenuItem(
//                 value: color,
//                 child: Text(
//                   color,
//                   style: TextStyle(
//                     color: Color(
//                       colorsCode[color],
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//             onChanged: ((val) {
//               setState(() {
//                 _currentColor = colorsCode[val];
//               });
//             }),
//           ),
//           //slider
//
//           RaisedButton(
//             color: Colors.lightBlue,
//             child: Text('Add'),
//             onPressed: () async {
//               try {
//                 await
//                     .addFolder(_currentName, _currentColor, provideId());
//               } catch (e) {
//                 print(e);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
