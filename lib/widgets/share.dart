import 'package:flutter/material.dart';
import 'package:Links/widgets/loading.dart';
import 'package:share/share.dart';

class ShareLink extends StatefulWidget {
  final String address;
  final String description;

  ShareLink({
    this.address,
    this.description,
  });

  @override
  _ShareLinkState createState() => _ShareLinkState();
}

class _ShareLinkState extends State<ShareLink> {
  String currentLinkAddress;
  String currentLinkDescription;

  TextEditingController _linkAddressController;
  TextEditingController _linkDescriptionController;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _linkAddressController = TextEditingController(text: widget.address);
    _linkDescriptionController =
        TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _onShareData(BuildContext context) async {
      final RenderBox box = context.findRenderObject();
      {
        await Share.share(currentLinkAddress ?? widget.address,
            subject: currentLinkDescription ?? widget.description,
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }
    }

    return loading
        ? Loading()
        : SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Share Link",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextFormField(
                      controller: _linkAddressController,
                      decoration: InputDecoration(
                        hintText: "Enter Link Address",
                        border: InputBorder.none,
                      ),
                      onChanged: (val) =>
                          setState(() => currentLinkAddress = val),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextFormField(
                      controller: _linkDescriptionController,
                      decoration: InputDecoration(
                        hintText: "Enter Link Address",
                        border: InputBorder.none,
                      ),
                      maxLines: 4,
                      onChanged: (val) =>
                          setState(() => currentLinkDescription = val),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      await _onShareData(context);
                      Navigator.pop(context);
                    }),
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFEB1555),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Share",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
