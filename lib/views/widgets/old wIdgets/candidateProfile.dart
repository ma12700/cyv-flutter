/* import 'package:flutter/material.dart';
import '../../../models/ini.dart';
import '../../screens/list.dart';
import 'dart:io';

class CandidateProfile extends StatefulWidget {
  @override
  _CandidateProfileState createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile> {
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  final double _imageHeight = 256.0;
  ListModel listModel;
  bool showOnlyCompleted = false;
  File _storedImage;
  @override
  void initState() {
    super.initState();
    listModel = new ListModel(_listKey, tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildTimeline(),
        _buildIamge(),
        _buildProfileRow(),
        _buildBottomPart(),
        // _buildFab(),
      ],
    );
  }

  Widget _buildIamge() {
    return new Positioned.fill(
      bottom: null,
      child: new ClipPath(
        clipper: new DialogonalClipper(),
        child: new Image.asset(
          'assets/images/backOfCandidate.png',
          fit: BoxFit.cover,
          height: _imageHeight,
          colorBlendMode: BlendMode.srcOver,
          color: new Color.fromARGB(120, 20, 10, 40),
        ),
      ),
    );
  }

  // Widget _buildTopHeader() {
  //   return new Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
  //     child: new Row(
  //       children: <Widget>[
  //         new Icon(Icons.menu, size: 32.0, color: Colors.white),
  //         new Expanded(
  //           child: new Padding(
  //             padding: const EdgeInsets.only(left: 16.0),
  //             child: new Text(
  //               "Timeline",
  //               style: new TextStyle(
  //                   fontSize: 20.0,
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.w300),
  //             ),
  //           ),
  //         ),
  //         new Icon(Icons.linear_scale, color: Colors.white),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildProfileRow() {
    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: new Row(
        children: <Widget>[
          // if (_storedImage != null)
          new CircleAvatar(
            radius: 40,
            // minRadius: 28.0,
            // maxRadius: 28.0,
            backgroundImage: _storedImage != null
                ? new FileImage(
                    _storedImage,
                  )
                : AssetImage("assets/images/help2.png"),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  "Reham Rafaat",
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return new Container(
      padding: new EdgeInsets.only(top: 250, left: 20, right: 20),
      child: SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // padding: EdgeInsets.only(left: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: Colors.grey)),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/facebook.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: Colors.grey)),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/facebook.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: Colors.grey)),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/facebook.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    )
                  ],
                  border: Border.all(width: 1, color: Colors.black)),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.access_time,
                          size: 20,
                          color: Style.primaryColor,
                        ),
                      ),
                      Text("3 min ago"),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "plaplaplaplaplaplaplaplaplaplaplaplaplapalaplaplapla",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      )),
                ],
              ),
            )
            // _buildMyTasksHeader(),
            // _buildTasksList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }
}

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 70.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
 */