import 'package:flutter/material.dart';
// import 'writeProgram.dart';

class TaskRow extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  final double dotSize = 12.0;

  const TaskRow(this.title, this.content, this.color);
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 32.0 - dotSize / 2),
            child: new Container(
              height: dotSize,
              width: dotSize,
              decoration:
                  new BoxDecoration(shape: BoxShape.circle, color: color),
            ),
          ),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  title,
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  content,
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
