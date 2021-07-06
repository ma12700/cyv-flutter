import 'package:cyv/controllers/candidate.dart';
import 'package:cyv/controllers/dialog.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:flutter/material.dart';

class WaiveWidget extends StatefulWidget {
  final Function changeWidget;
  WaiveWidget(this.changeWidget);
  _WaiveWidgetState createState() => _WaiveWidgetState();
}

class _WaiveWidgetState extends State<WaiveWidget> {
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            (lang == 'En'
                ? 'Do you want to waive from candidacy?'
                : dictionary['DYWW']),
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
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Image.asset(
              'assets/images/waive.png',
            ),
          ),
          isLoad
              ? CircularProgressIndicator()
              : Container(
                  padding: EdgeInsets.all(20),
                  alignment: lang == "En"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: Style.buttonColor(Style.lightColor),
                      backgroundColor: Style.buttonColor(Style.primaryColor),
                      shape: Style.buttonShape,
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoad = !isLoad;
                      });
                      bool result = await CandidatesCtr.waive();
                      setState(() {
                        isLoad = !isLoad;
                      });
                      if (result) {
                        User.type = "Voter";
                        widget.changeWidget('Home');
                      } else {
                        showErrorDialog(
                            lang == "En" ? 'An Error Occured' : "حدث خطأ ما",
                            context);
                      }
                    },
                    child: Text(
                      (lang == 'En' ? 'Yes, I Confirm' : dictionary['YIC']),
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
        ],
      ),
    );
  }
}
