import 'package:cyv/models/language.dart';
import 'package:cyv/views/screens/home_screen.dart';
import 'package:cyv/views/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:google_ml_vision/google_ml_vision.dart';

class FaceSetectWidget extends StatefulWidget {
  @override
  _FaceSetectWidgetState createState() => _FaceSetectWidgetState();
}

class _FaceSetectWidgetState extends State<FaceSetectWidget> {
  Future<void> _initializeControllerFuture;
  final FaceDetector faceDetector = GoogleVision.instance.faceDetector();
  GoogleVisionImage visionImage;
  List<Face> _faces = <Face>[];
  CameraController _camera;
  CameraLensDirection _direction = CameraLensDirection.front;
  @override
  void initState() {
    super.initState();
  }

  Future<CameraDescription> _getCamera(CameraLensDirection dir) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
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

  Future<void> faceDetect() async {
    try {
      if (!_camera.value.isTakingPicture) {
        await _initializeControllerFuture;
        final image = await _camera.takePicture();
        visionImage = GoogleVisionImage.fromFilePath(image?.path);
        _faces = await faceDetector.processImage(visionImage);
        if (_faces.length == 1) {
          _camera.dispose();
          faceDetector.close();
          Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
        } else {
          print(_faces.length);
        }
      }
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
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          child: FutureBuilder<void>(
            future: _initializeCamera(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_camera);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        ButtonWidget(
          text: (lang == 'En' ? "Capture" : dictionary['Capture']),
          navigate: faceDetect,
        )
      ],
    );
  }
}
