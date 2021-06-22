import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';

class ConfirmWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClipRRect(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    (lang == 'En' ? "Enter your code" : dictionary['EYC']),
                    style: TextStyle(
                        color: Style.darkColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
              Directionality(
                textDirection: TextDirection.ltr,
                child: VerificationCodeInput(
                  itemSize: 40,
                  textStyle: TextStyle(fontSize: 23.0, fontFamily: "Roboto"),
                  itemDecoration: BoxDecoration(
                      // color: Style.primaryColor,
                      border: Border(
                    bottom: BorderSide(color: Style.primaryColor, width: 2),
                  )),
                  keyboardType: TextInputType.number,
                  length: 4,
                  onCompleted: (String value) {
                    print(value);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: InkWell(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: (lang == 'En'
                            ? "Didn't receive the code? "
                            : dictionary['DRC']),
                        style: TextStyle(
                            color: Style.darkColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              // recognizer: widget.onTapRecognizer,
                              text: (lang == 'En'
                                  ? " RESEND"
                                  : dictionary['Resend']),
                              // recognizer: onTapRecognizer,
                              style: TextStyle(
                                  color: Style.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
