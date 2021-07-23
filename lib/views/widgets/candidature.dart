import 'package:cyv/controllers/candidature.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/requirements.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:cyv/views/screens/home_screen.dart';
import 'package:cyv/views/widgets/dialog.dart';
import 'package:cyv/views/widgets/form/topPart.dart';
import 'package:flutter/material.dart';
import 'package:cyv/views/widgets/app_bar_widget.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

//InputDecoration
_inputDecoration(label) => InputDecoration(
    labelText: label,
    fillColor: Style.lightColor,
    border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(18.0),
        borderSide: new BorderSide()));

class CandidatureForm extends StatefulWidget {
  static const routeName = 'Candidature form';
  final _formKey = GlobalKey<FormState>();
  @override
  _CandidatureFormState createState() => _CandidatureFormState();
}

class _CandidatureFormState extends State<CandidatureForm> {
  String trackID;
  bool isSend = false;
  void setLanguage() {
    setState(() {
      lang = lang == "En" ? "ع" : "En";
      direction = lang == "En" ? TextDirection.ltr : TextDirection.rtl;
    });
  }

  @override
  Widget build(BuildContext context) {
    trackID = ModalRoute.of(context).settings.arguments;
    return Directionality(
        textDirection: (lang == "En" ? TextDirection.ltr : TextDirection.rtl),
        child: Scaffold(
          appBar: appBarWidget(setLanguage, title: "Request Form"),
          body: Stack(
            children: [
              TopPartWidget(),
              Container(
                  margin: const EdgeInsets.only(
                      top: 200, left: 10, right: 10, bottom: 80),
                  child: RequirementsModel.requirements.isEmpty
                      ? FutureBuilder(
                          future: CandidatureCtr.fetchRequirements(),
                          builder: (ctx, fetchResultSnapshot) =>
                              fetchResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : requirementsWidget())
                      : requirementsWidget()),
              Container(
                alignment: Alignment.bottomRight,
                width: double.infinity,
                child: !isSend
                    ? Container(
                        margin: EdgeInsets.all(20),
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isSend = true;
                              });
                              RequirementsModel.requirements
                                  .forEach((requirement) {
                                if (requirement.type == "Image" &&
                                    requirement.file == null) {
                                  requirement.answer = "Add Image";
                                  setState(() {
                                    isSend = false;
                                  });
                                  return;
                                }
                              });
                              if (!widget._formKey.currentState.validate()) {
                                setState(() {
                                  isSend = false;
                                });
                                return;
                              }
                              bool res =
                                  await CandidatureCtr.sendRequest(trackID);
                              if (res) {
                                User.isCandidature = true;
                                showErrorDialog(
                                    lang == "En"
                                        ? "send successfuly"
                                        : "تم الارسال",
                                    context,
                                    title: "Succeed",
                                    backToHome: true);
                              } else {
                                showErrorDialog(
                                    lang == "En"
                                        ? "An Error Occured"
                                        : "هناك خطأ",
                                    context);
                              }
                              setState(() {
                                isSend = false;
                              });
                            },
                            child: Text("Send"),
                            style: ElevatedButton.styleFrom(
                              primary: Style.primaryColor,
                            )),
                      )
                    : Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: CircularProgressIndicator()),
              )
            ],
          ),
        ));
  }

  Widget requirementsWidget() {
    return Form(
        key: widget._formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
            key: Key("Candidature"),
            child: Column(
                children: RequirementsModel.requirements.map((requirement) {
              switch (requirement.type) {
                case 'Text':
                case 'Email':
                case 'Number':
                case 'Date':
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                        decoration: _inputDecoration(requirement.title +
                            (requirement.type == "Date" ? "(YYYY-MM-DD)" : "")),
                        initialValue: requirement.answer,
                        validator: (value) {
                          switch (requirement.type) {
                            case "Email":
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);

                              if (!emailValid) {
                                return (lang == 'En'
                                    ? "Enter valid Email"
                                    : dictionary["EVE"]);
                              }
                              break;
                            case "Number":
                              if (num.tryParse(value) == null) {
                                return (lang == 'En'
                                    ? "Enter valid Number"
                                    : dictionary["EVN"]);
                              }
                              break;
                            case "Text":
                              if (value == "") {
                                return "Enter the answeer";
                              }
                              break;
                            case "Date":
                              try {
                                DateTime.parse(value);
                              } catch (e) {
                                return "Enter Valid Date";
                              }
                              break;
                          }

                          return null;
                        },
                        onChanged: (value) {
                          requirement.answer = value;
                        },
                        style: TextStyle(
                            color: Color.fromRGBO(242, 160, 61, 1),
                            fontSize: 14.0),
                        keyboardType: keypoard(requirement.type)),
                  );
                case 'Select':
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            requirement.title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          DropdownButton(
                              value: requirement.answer,
                              items: requirement.values
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child:
                                      Container(width: 200, child: Text(value)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  requirement.answer = value;
                                });
                              })
                        ],
                      ));
                case 'Image':
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                          child: Column(children: [
                        Column(
                          children: [
                            Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: requirement.file != null
                                        ? Image.file(
                                            requirement.file,
                                            fit: BoxFit.fill,
                                          )
                                        : Container(),
                                    margin: EdgeInsets.all(20),
                                    width: 80,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Style.darkColor)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 13, right: 20),
                                    child: Text(requirement.title),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        final file =
                                            await ImagePicker().getImage(
                                          source: ImageSource.camera,
                                          maxWidth: 600,
                                        );

                                        if (file == null) {
                                          return;
                                        }
                                        setState(() {
                                          requirement.file = File(file.path);
                                          requirement.answer = "";
                                        });
                                      },
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Icon(Icons.camera_alt),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text("Add"))
                                          ]))
                                ]),
                            Text(
                              requirement.answer,
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        )
                      ])));
                default:
                  return Container(
                      margin: EdgeInsets.all(10),
                      child: Text('No Requirements'));
              }
            }).toList())));
  }

  TextInputType keypoard(String type) {
    switch (type) {
      case "Text":
        return TextInputType.text;
        break;
      case "Email":
        return TextInputType.emailAddress;
        break;
      case "Number":
        return TextInputType.number;
        break;
      case "Date":
        return TextInputType.datetime;
        break;
      default:
        return TextInputType.text;
    }
  }
}
