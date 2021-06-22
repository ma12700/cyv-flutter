import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function navigate;

  const ButtonWidget({Key key, this.text, this.navigate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: navigate == null
                ? Style.buttonColor(Style.nullColor)
                : Style.buttonColor(Style.primaryColor)),
        onPressed: navigate,
        child: Text(
          text,
          style: TextStyle(
            color: Style.lightColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
