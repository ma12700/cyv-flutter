import 'package:flutter/material.dart';

// import './ani.dart';

class CandidatureForm extends StatelessWidget {
  final Function navigate;
  CandidatureForm(this.navigate);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Stack(
        //overflow: Overflow.visible,
        children: <Widget>[
          // _buildTimeline(),
          _buildIamge(),
          _buildIamge2(),
          _buildIamge3(),
          _buildIamge4(),
          _buildIamge5()
          // _buildProfileRow(),
          // _buildBottomPart(),
          // _buildFab(),
        ],
      ),
    );
  }

  Widget _buildIamge() {
    return new Positioned.fill(
        bottom: null,
        child: new ClipPath(
          clipper: new DialogonalClipper2(),
          child: Container(
            color: Color(0xffD38693),
            height: 550,
          ),
        ));
  }

  Widget _buildIamge2() {
    return new Positioned.fill(
        bottom: null,
        child: new ClipPath(
          clipper: new DialogonalClipper(),
          child: Container(
            color: Color.fromRGBO(127, 102, 216, 1),
            // padding: EdgeInsets.only(bottom: 30),
            // color: Style.primaryColor,
            height: 530,
          ),
        ));
  }

  Widget _buildIamge3() {
    return Container(
      padding: const EdgeInsets.only(left: 30, top: 100),
      child: Image.asset(
        "assets/images/form.png",
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildIamge4() {
    return Padding(
      padding: const EdgeInsets.only(right: 50, left: 10, top: 10),
      child: Text(
        "Here you can fill a form to request a candidacy ",
        style: TextStyle(
          color: Colors.white,
          fontSize: 35.0,
          fontFamily: "Bobbers",
          shadows: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 0),
            )
          ],
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildIamge5() {
    return Container(
      padding: const EdgeInsets.only(top: 540, left: 19),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 50,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fill,
            ),
          ),
          InkWell(
            onTap: () {
              navigate(
                'CnadidatureForm',
                flagArrow: true,
              );
            },
            child: Container(
                width: 230,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffD38693),
                    border: Border.all(width: 2, color: Colors.black)),
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
    );
  }
}

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 350);
    var controllPoint = Offset(70, size.height);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class DialogonalClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 380);
    var controllPoint = Offset(70, size.height);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
