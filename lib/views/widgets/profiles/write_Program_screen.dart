import 'package:cyv/controllers/candidate.dart';
import 'package:cyv/controllers/dialog.dart';
import 'package:cyv/controllers/user.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:cyv/views/widgets/profiles/linkWidget.dart';
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
    return !UserCtr.programFetched
        ? FutureBuilder(
            future: UserCtr.fetchProgram(),
            builder: (ctx, fetchResultSnapshot) =>
                fetchResultSnapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : body())
        : body();
  }

  Widget body() {
    return Column(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Form(
                  key: _formKey,
                  child: ListView(children: [
                    //add links
                    Column(
                      children: [
                        LinkWidget(true),
                        LinkWidget(false),
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
                            initialValue: User.program,
                            onChanged: (value) {
                              User.program = value;
                            },
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
                      ],
                    )
                  ])))),
      //save button
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: _isLoading
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: CircularProgressIndicator())
                  : InkWell(
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
                    )),
        ],
      ),
    ]);
  }
}
