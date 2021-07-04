import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/widgets/login/auth_form.dart';
import 'package:flutter/material.dart';

class TextLoginWidget extends StatelessWidget {
  final AuthMode authMode;
  final Function changeMode;
  TextLoginWidget(this.authMode, this.changeMode);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: lang == "En" ? Alignment.centerRight : Alignment.centerLeft,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          if (authMode == AuthMode.Reset || authMode == AuthMode.Confirm) {
            changeMode(AuthMode.Login);
          }
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Text(
            authMode == AuthMode.Login
                ? "" //(lang == 'En' ? "Login As a guest" : dictionary['LAG'])
                : (lang == 'En' ? "Login Instead" : dictionary['LI']),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Style.darkColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
