import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:flutter/material.dart';

class EmailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Style.primaryColor,
      ),
      cursorColor: Style.primaryColor,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Style.primaryColor,
        ),
        labelText: (lang == 'En' ? "Email" : dictionary['Email']),
      ),
      validator: (value) {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value);

        if (!emailValid) {
          return (lang == 'En' ? "Enter valid Email" : dictionary["EVE"]);
        }

        return null;
      },
      onSaved: (value) {
        User.email = value;
      },
    );
  }
}
