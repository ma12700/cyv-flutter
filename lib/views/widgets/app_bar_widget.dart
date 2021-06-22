import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';

AppBar appBarWidget(Function setLanguage, {String title = ''}) {
  var appBar = AppBar(
    title: Text(
      title,
      style: TextStyle(color: Style.darkColor, fontSize: 20),
    ),
    backgroundColor: Style.thirdColor,
    iconTheme: IconThemeData(
      color: Style.primaryColor,
    ),
    elevation: 0.0,
    actions: <Widget>[
      TextButton(
        onPressed: setLanguage,
        child: Text(
          lang == "En" ? "ع" : "En",
          style: TextStyle(color: Style.primaryColor, fontSize: 20),
        ),
      ),
      Image.asset("assets/images/logo.png"),
    ],
  );
  return appBar;
}
