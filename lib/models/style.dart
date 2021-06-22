import 'package:flutter/material.dart';

class Style {
  static Color primaryColor = Color.fromRGBO(127, 102, 216, 1);
  static Color backgroundColor = Colors.indigoAccent[50];
  static Color secondColor = Color.fromRGBO(255, 88, 119, 1);
  static Color thirdColor = Color.fromRGBO(251, 231, 144, 1);
  static Color darkColor = Colors.black;
  static Color borderColor = Colors.black26;
  static Color lightColor = Colors.white;
  static Color nullColor = Colors.grey;
  static Color selectedColor = Colors.green;

  static MaterialStateProperty<Color> buttonColor(color) =>
      MaterialStateProperty.resolveWith((states) => color);

  static MaterialStateProperty<RoundedRectangleBorder> buttonShape =
      MaterialStateProperty.resolveWith((states) =>
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
}
