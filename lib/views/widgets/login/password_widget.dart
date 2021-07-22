import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:flutter/material.dart';

class PasswordWidget extends StatefulWidget {
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _isVisibale = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Style.primaryColor,
      ),
      cursorColor: Style.primaryColor,
      obscureText: _isVisibale,
      decoration: InputDecoration(
          suffixStyle: TextStyle(
            color: Style.primaryColor,
          ),
          icon: Icon(
            Icons.vpn_key,
            color: Style.primaryColor,
          ),
          labelText: (lang == 'En' ? "Password" : dictionary['Password']),
          suffixIcon: _isVisibale
              ? IconButton(
                  icon: Icon(
                    Icons.visibility,
                    color: Style.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isVisibale = false;
                    });
                  })
              : IconButton(
                  icon: Icon(
                    Icons.visibility_off,
                    color: Style.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isVisibale = true;
                    });
                  })),
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value.length <= 4) {
          return (lang == 'En'
              ? "The length of password must be at least 5"
              : dictionary['TLP']);
        }
        return null;
      },
      onSaved: (value) {
        User.password = value;
      },
    );
  }
}
