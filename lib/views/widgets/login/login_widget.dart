import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/widgets/login/auth_form.dart';
import 'package:cyv/views/widgets/login/email_widget.dart';
import 'package:cyv/views/widgets/login/password_widget.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final Function changeMode;
  LoginWidget(this.changeMode);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailWidget(),
        SizedBox(
          height: 15,
        ),
        PasswordWidget(),
        Container(
            padding: EdgeInsets.only(
                left: lang == "En" ? 35 : 0,
                right: lang == "En" ? 0 : 35,
                top: 15),
            width: double.infinity,
            alignment:
                lang == "En" ? Alignment.centerLeft : Alignment.centerRight,
            child: InkWell(
                child: Text(
                  (lang == 'En' ? "Forget the password?" : dictionary['FTP']),
                  style: TextStyle(
                      color: Style.nullColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                onTap: () {
                  changeMode(AuthMode.Reset);
                })),
      ],
    );
  }
}
