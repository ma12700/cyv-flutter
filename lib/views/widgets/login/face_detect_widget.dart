import 'dart:io';
import 'package:cyv/controllers/auth.dart';
import 'package:cyv/controllers/dialog.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/views/screens/home_screen.dart';
import 'package:cyv/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:google_ml_vision/google_ml_vision.dart';

class FaceSetectWidget extends StatefulWidget {
  @override
  _FaceSetectWidgetState createState() => _FaceSetectWidgetState();
}

class _FaceSetectWidgetState extends State<FaceSetectWidget> {
  final FaceDetector faceDetector = GoogleVision.instance.faceDetector();
  GoogleVisionImage visionImage;
  List<Face> _faces = <Face>[];
  CameraController _camera;
  CameraLensDirection _direction = CameraLensDirection.front;
  String text = "message";
  File file;
  bool isSend = false;
  @override
  void initState() {
    super.initState();
  }

  Future<CameraDescription> _getCamera(CameraLensDirection dir) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.lastWhere(
        (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  Future<void> _initializeCamera() async {
    _camera = CameraController(
      await _getCamera(_direction),
      ResolutionPreset.medium,
    );

    await _camera.initialize();
    print('init camera');
  }

  void onComplete(result) {
    if (result == "matched") {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } else {
      setState(() {
        isSend = false;
      });

      showErrorDialog((lang == "En" ? result : dictionary[lang]), context);
    }
  }

  Future<void> faceDetect() async {
    try {
      if (!_camera.value.isTakingPicture) {
        final image = await _camera.takePicture();
        /* visionImage = GoogleVisionImage.fromFilePath(image?.path);
        _faces = await faceDetector.processImage(visionImage);
        print('heree:ADVad');
        print('heree' + _faces.length.toString());
        if (_faces.length == 1) { */
        file = File(image.path);
        setState(() {
          isSend = true;
        });
        await AuthCtr.login(file, onComplete);
      } else {
        print(_faces.length);
      }
      //}
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _camera.dispose();
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(isSend);
    return Column(
      children: [
        Container(
          height: size.height / 2.5,
          width: size.width - 50,
          child: !isSend
              ? FutureBuilder<void>(
                  future: _initializeCamera(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(_camera);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : Image.file(file),
        ),
        SizedBox(
          height: 20,
        ),
        !isSend
            ? ButtonWidget(
                text: (lang == 'En' ? "Login" : dictionary['Login']),
                navigate: faceDetect,
              )
            : CircularProgressIndicator(),
        //file != null ? Image.file(file) : Text('null')
      ],
    );
  }
}
