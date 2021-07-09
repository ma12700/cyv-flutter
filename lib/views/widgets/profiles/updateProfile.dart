import 'dart:io';

import 'package:cyv/views/widgets/dialog.dart';
import 'package:cyv/controllers/user.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:cyv/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileWidget extends StatefulWidget {
  _UpdateProfileWidgetState createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  bool updatePassword = false;
  bool show = false;
  File file;
  int index = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...User.attributesValues
            .map(
              (attr) => attr.update
                  ? attr.values.length > 4
                      ? Container(
                          margin: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                attr.key + ':',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              DropdownButton(
                                  value: attr.answer,
                                  items: attr.values
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Container(
                                          width: 200, child: Text(value)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      attr.answer = value;
                                    });
                                  })
                            ],
                          ))
                      : Container(
                          margin: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                attr.key + ':',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              ...attr.values.map((val) {
                                index++;
                                return Row(
                                  children: [
                                    Radio(
                                        activeColor: Style.secondColor,
                                        value: val,
                                        groupValue: attr.answer,
                                        onChanged: (value) {
                                          setState(() {
                                            attr.answer = value;
                                          });
                                        }),
                                    Text(
                                      val,
                                      style: new TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ],
                          ))
                  : Container(),
            )
            .toList(),
        Row(children: <Widget>[
          Checkbox(
            activeColor: Style.secondColor,
            value: updatePassword,
            onChanged: (bool value) {
              setState(() {
                updatePassword = value;
              });
            },
          ),
          Text(lang == "En" ? 'Reset Password' : 'تغيير الرم السرى')
        ]),
        updatePassword
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFormField(
                    obscureText: !show,
                    decoration: InputDecoration(
                        labelText: lang == "En"
                            ? 'Reset Password'
                            : 'تغيير الرم السرى',
                        fillColor: Style.lightColor,
                        suffixIcon: IconButton(
                          icon: show
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              show = !show;
                            });
                          },
                        ),
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            borderSide: new BorderSide())),
                    style: TextStyle(
                        color: Color.fromRGBO(242, 160, 61, 1), fontSize: 14.0),
                    keyboardType: TextInputType.text),
              )
            : Container(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ButtonWidget(
              text: (lang == "En" ? 'Update' : 'تحديث'),
              navigate: () async {
                final bool result = await UserCtr.updateStatistics();
                if (result) {
                  showErrorDialog(
                      (lang == "En" ? "Updated Successfully" : "تم التعديل"),
                      context,
                      title: "Succeed");
                } else {
                  showErrorDialog(
                      (lang == "En" ? "An Error Occurred" : "لقد حدث خطأ ما"),
                      context);
                }
              },
            ),
          ),
        ])
      ],
    );
  }
}
