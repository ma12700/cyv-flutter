import 'package:cyv/models/style.dart';
import 'package:cyv/models/user_model.dart';
import 'package:flutter/material.dart';

class UpdateProfileWidget extends StatefulWidget {
  _UpdateProfileWidgetState createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  bool updatePassword = false;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
