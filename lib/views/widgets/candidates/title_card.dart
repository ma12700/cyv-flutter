import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  final String title;
  TitleCard(this.title);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Style.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      color: Style.primaryColor,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Style.lightColor),
            textAlign: TextAlign.center,
          )),
    );
  }
}
