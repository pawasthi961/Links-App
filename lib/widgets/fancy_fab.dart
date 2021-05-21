import 'package:flutter/material.dart';
import 'package:simple_animated_icon/simple_animated_icon.dart';
import 'package:Links/widgets/add_link.dart';
import 'package:Links/widgets/add_folder.dart';

class FancyFab extends StatefulWidget {
  final currentRootFolderId;

  FancyFab({this.currentRootFolderId});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Color(0xFFEB1555),
      end: Color(0xaaEB1555),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  // Widget addLink() {
  //   return
  // }
  //
  // Widget addFolder() {
  //   return
  // }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: "toggle",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: SimpleAnimatedIcon(
          color: Colors.white,
          startIcon: Icons.add,
          endIcon: Icons.close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _showFolderAddBox() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.dark(),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  width: 400.0,
                  child: AddFolder(currentId: widget.currentRootFolderId),
                ),
              ),
            );
          });
    }

    void _showLinkAddBox() {
      showDialog(
          useSafeArea: true,
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.dark(),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                    width: 400.0,
                    child: AddLink(currentId: widget.currentRootFolderId)),
              ),
            );
          });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: Container(
            child: FloatingActionButton(
              backgroundColor: Color(0xFFEB1555),
              heroTag: "addFolder",
              onPressed: (() {
                _showFolderAddBox();
              }),
              tooltip: 'Add Folder',
              child: Icon(
                Icons.folder,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: Container(
            child: FloatingActionButton(
              backgroundColor: Color(0xFFEB1555),
              heroTag: "addLink",
              onPressed: (() {
                _showLinkAddBox();
              }),
              tooltip: 'Add Link',
              child: Icon(
                Icons.link,
                color: Colors.white,
              ),
            ),
          ),
        ),
        toggle(),
      ],
    );
  }
}
