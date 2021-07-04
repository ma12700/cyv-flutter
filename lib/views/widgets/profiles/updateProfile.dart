import 'dart:io';

import 'package:cyv/models/style.dart';
import 'package:cyv/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileWidget extends StatefulWidget {
  _UpdateProfileWidgetState createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  bool updatePassword = false;
  bool show = false;
  File file;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Container(
                child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  child: file != null
                      ? Image.file(
                          file,
                          fit: BoxFit.fill,
                        )
                      : Container(),
                  margin: EdgeInsets.all(20),
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Style.darkColor)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 20),
                  child: Text('Update Image'),
                ),
                InkWell(
                    onTap: () async {
                      var image = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                        maxWidth: 600,
                      );

                      if (image == null) {
                        return;
                      }
                      setState(() {
                        file = File(image.path);
                      });
                    },
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.camera_alt),
                          Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("Add"))
                        ]))
              ])
            ]))),
        ...User.attributesValues
            .map(
              (attr) => attr.update
                  ? Container(
                      margin: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            attr.key + ':',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          DropdownButton(
                              value: attr.answer,
                              items: attr.values.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child:
                                      Container(width: 200, child: Text(value)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  attr.answer = value;
                                });
                              })
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
          Text('Reset Password')
        ]),
        updatePassword
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFormField(
                    obscureText: !show,
                    decoration: InputDecoration(
                        labelText: 'Reset Password',
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
      ],
    );
  }
}
