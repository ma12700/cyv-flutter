import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/widgets/login/auth_form.dart';
import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  final AuthMode authMode;
  final Function changeMode;
  final Function submit;
  AuthButtonWidget(this.authMode, this.changeMode, this.submit);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        alignment: lang == "En" ? Alignment.centerRight : Alignment.centerLeft,
        child: ElevatedButton(
          style: ButtonStyle(
            foregroundColor: Style.buttonColor(Style.lightColor),
            backgroundColor: Style.buttonColor(Style.primaryColor),
            shape: Style.buttonShape,
          ),
          onPressed: () {
            authMode == AuthMode.Reset
                ? changeMode(AuthMode.Confirm)
                : submit();
          },
          child: Container(
            padding: EdgeInsets.all(15),
            width: 150,
            alignment: Alignment.center,
            child: Text(
              authMode == AuthMode.Login
                  ? (lang == 'En' ? "Login" : dictionary['Login'])
                  : authMode == AuthMode.Reset
                      ? (lang == 'En' ? "Next" : dictionary['Next'])
                      : (lang == 'En' ? "Verify" : dictionary['Verify']),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
