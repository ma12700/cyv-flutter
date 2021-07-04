import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';

class TopPartWidget extends StatelessWidget {
  final dys = [50.0, 30.0];
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ...dys.map((dy) {
        i++;
        return Positioned.fill(
            bottom: null,
            child: new ClipPath(
              clipper: new DialogonalClipper(dy),
              child: Container(
                color: i == 1 ? Style.secondColor : Style.primaryColor,
                height: 200,
              ),
            ));
      }).toList(),
      Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Election Request",
                  style: TextStyle(
                      shadows: [
                        BoxShadow(
                          color: Style.primaryColor,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        )
                      ],
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Style.darkColor),
                ),
              ),
              Image.asset(
                "assets/images/formcand.png",
                fit: BoxFit.cover,
              )
            ],
          ))
    ]);
  }
}

class DialogonalClipper extends CustomClipper<Path> {
  final double dy;
  DialogonalClipper(this.dy);
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 170);
    var controllPoint = Offset(
      size.height,
      dy,
    );
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
