import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:cyv/views/widgets/profiles/profileData.dart';
import 'package:cyv/views/widgets/profiles/updateProfile.dart';
import 'package:flutter/material.dart';
import 'profiles/taskrow.dart';
import 'profiles/write_Program_screen.dart';

class MyProfileWidget extends StatefulWidget {
  final int index;
  MyProfileWidget(this.index);
  @override
  _MyProfileWidgetState createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.index < 2
        ? SingleChildScrollView(
            child: Stack(
              children: [
                // vertical narrow line
                widget.index == 0
                    ? Positioned(
                        top: 0.0,
                        bottom: 0.0,
                        left: lang == "En" ? 31.5 : null,
                        right: lang == "En" ? null : 31.5,
                        child: new Container(
                          width: 1.0,
                          color: Style.nullColor,
                        ),
                      )
                    : Container(),
                // backimage - user image - name
                Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        //backimage
                        Container(
                            width: double.infinity,
                            height: 200.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                'assets/images/backOfCandidate.png',
                              ),
                              fit: BoxFit.cover,
                            ))),
                        //user image - name
                        Container(
                          width: double.infinity,
                          padding: new EdgeInsets.only(top: 110),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // user image
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(User.img)),
                                    border: Border.all(
                                        width: 1, color: Style.darkColor),
                                    color: Style.lightColor),
                                margin: EdgeInsets.all(10),
                              ),
                              //name
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                alignment: Alignment.center,
                                child: Text(
                                  User.name,
                                  style: new TextStyle(
                                      fontSize: 22.0,
                                      color: Style.darkColor,
                                      fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    widget.index == 0
                        ? ProfileDataWidget()
                        : UpdateProfileWidget()
                  ],
                ),
              ],
            ),
          )
        : WriteProgramScreen();
  }
}
