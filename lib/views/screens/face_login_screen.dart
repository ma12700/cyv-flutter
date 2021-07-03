import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../widgets/login/face_detect_widget.dart';
import 'package:cyv/models/language.dart';

// still want to add design to that page
class FaceRecognitionScreen extends StatelessWidget {
  static const routeName = '/face';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lang == 'En' ? "Login by your face" : dictionary['LBYF'],
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FaceSetectWidget(),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Text(
                      lang == 'En'
                          ? "make your face take more than 60% of the picture"
                          : dictionary['MYFTM'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
