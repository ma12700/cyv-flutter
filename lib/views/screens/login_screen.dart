import 'package:cyv/models/language.dart';
import 'package:cyv/views/widgets/login/auth_form.dart';
import 'package:flutter/material.dart';

// used for login or reset and consider as the root of the widgets
class LoginScreen extends StatelessWidget {
  static String routeName = "login Screen";
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Directionality(
          textDirection: direction,
          child: Container(
              width: deviceSize.width,
              height: deviceSize.height,
              child: Column(children: [
                Expanded(
                    // upper image
                    child: Container(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/backOfLogin.png",
                          fit: BoxFit.fill,
                        ))),
                // form of login or reset
                AuthForm()
              ]))),
    ));
  }
}
