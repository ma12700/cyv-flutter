import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Container(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Image.asset(
            'assets/images/backOfSplash.png',
            fit: BoxFit.fill,
          ),
        ),
        Center(child: Image.asset('assets/images/CYV.png')),
      ]),
    );
  }
}
