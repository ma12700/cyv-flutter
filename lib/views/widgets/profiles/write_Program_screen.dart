import 'package:cyv/controllers/candidate.dart';
import 'package:cyv/controllers/dialog.dart';
import 'package:cyv/controllers/user.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:flutter/material.dart';

class WriteProgramScreen extends StatefulWidget {
  @override
  _WriteProgramScreenState createState() => _WriteProgramScreenState();
}

class _WriteProgramScreenState extends State<WriteProgramScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    bool isSucceed = await CandidatesCtr.updateProgram();
    if (isSucceed) {
      showErrorDialog(
          lang == "En" ? "Updated Successfully" : "تم التحديث", context,
          title: 'Confirm');
    } else {
      showErrorDialog(lang == "En" ? 'An Error Occurred' : 'حدث خطأ!', context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final urlLink = {
      (lang == 'En' ? "facebook link" : dictionary['FL']): {
        "icon": "assets/images/facebook.png",
        "value": User.facebookURL
      },
      (lang == 'En' ? "twitter link" : dictionary['TL']): {
        "icon": "assets/images/twitter.png",
        "value": User.twitterURL
      },
    };
    return FutureBuilder(
      future: UserCtr.fetchProgram(),
      builder: (ctx, fetchResultSnapshot) =>
          fetchResultSnapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        //add links
                        Column(
                            children: urlLink.entries.map((url) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 0),
                                  )
                                ],
                                color: Style.lightColor,
                                border: Border.all(
                                  width: 2,
                                  color: Style.darkColor,
                                )),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  width: 30,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            url.value['icon'],
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                                Expanded(
                                    child: Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: TextFormField(
                                          initialValue: url.value['value'],
                                          validator: (value) {
                                            if (value != "") {
                                              if ((lang == 'En' &&
                                                      url.key ==
                                                          "facebook link") ||
                                                  (lang != 'En' &&
                                                      url.key ==
                                                          dictionary['FL'])) {
                                                if (!url.value['value'].startsWith(
                                                    'https://www.facebook.com/')) {
                                                  return url.key + lang == "En"
                                                      ? " must start with "
                                                      : " يجب أن يبدأ ب " +
                                                          " https://www.facebook.com/";
                                                }
                                              } else {
                                                if (!url.value['value']
                                                    .startsWith(
                                                        'https://twitter.com/')) {
                                                  return url.key + lang == "En"
                                                      ? " must start with "
                                                      : " يجب أن يبدأ ب " +
                                                          " https://twitter.com/";
                                                }
                                              }
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: url.key,
                                              hintStyle: TextStyle(
                                                color: Style.nullColor,
                                              ),
                                              border: InputBorder.none),
                                        ))),
                              ],
                            ),
                          );
                        }).toList()),

                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              color: Style.lightColor,
                              border: Border.all(
                                width: 2,
                                color: Style.darkColor,
                              )),
                          child:
                              //to add the election program
                              TextFormField(
                            maxLines: 15,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: (lang == 'En'
                                  ? "Write your program"
                                  : dictionary['WYP']),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        //save button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: _submit,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Style.primaryColor,
                                ),
                                child: Text(
                                  (lang == 'En' ? "Save" : dictionary["Save"]),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Style.lightColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
