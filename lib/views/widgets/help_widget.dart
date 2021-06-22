import 'package:cyv/models/help_modal.dart';
import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';

class HelpWidget extends StatefulWidget {
  _HelpWidgetState createState() => _HelpWidgetState();
}

class _HelpWidgetState extends State<HelpWidget> {
  int n = HelpModel.helpContents.length;
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _index = index;
                });
              },
              children: HelpModel.helpContents.map((helpContent) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        helpContent.question,
                        style: TextStyle(
                            shadows: [
                              BoxShadow(
                                color: Style.primaryColor,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 0),
                              )
                            ],
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Style.secondColor),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Image.asset(
                                helpContent.img,
                                height: 250,
                              ),
                            ),
                            Text(
                              helpContent.ans,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dots(),
          )
        ],
      ),
    );
  }

  List<Widget> dots() {
    List<Widget> ch = [];
    for (var i = 0; i < n; i++) {
      ch.add(Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: i == _index ? Style.primaryColor : Style.nullColor,
            shape: BoxShape.circle,
          )));
    }
    return ch;
  }
}
