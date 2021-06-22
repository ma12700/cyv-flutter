import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';
import 'package:cyv/views/widgets/app_bar_widget.dart';

class WriteProgramScreen extends StatefulWidget {
  static const routeName = '/WriteProgram';
  final urlLink = {
    (lang == 'En' ? "twitter link" : dictionary['TL']):
        "assets/images/twitter.png",
    (lang == 'En' ? "facebook link" : dictionary['FL']):
        "assets/images/facebook.png",
  };
  @override
  _WriteProgramScreenState createState() => _WriteProgramScreenState();
}

class _WriteProgramScreenState extends State<WriteProgramScreen> {
  final _formKey = GlobalKey<FormState>();
  void submit() {
    _formKey.currentState.save();
  }

  void setLanguage() {
    setState(() {
      lang = lang == "En" ? "ع" : "En";
      direction = lang == "En" ? TextDirection.ltr : TextDirection.rtl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleName = ModalRoute.of(context).settings.arguments;
    return Directionality(
      textDirection: (lang == "En" ? TextDirection.ltr : TextDirection.rtl),
      child: Scaffold(
        appBar: appBarWidget(setLanguage, title: titleName),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                //add links
                Column(
                    children: widget.urlLink.entries.map((url) {
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
                                    url.value,
                                  ),
                                  fit: BoxFit.fill)),
                        ),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: 16),
                                child: TextField(
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
                      onTap: () {},
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
      ),
    );
  }
}
