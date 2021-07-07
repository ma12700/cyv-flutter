import 'dart:async';
import 'package:cyv/controllers/auth.dart';
import 'package:cyv/views/widgets/dialog.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/views/screens/face_login_screen.dart';
import 'package:cyv/views/widgets/login/auth_button_widget.dart';
import 'package:cyv/views/widgets/login/confirmWidget.dart';
import 'package:cyv/views/widgets/login/email_widget.dart';
import 'package:cyv/views/widgets/login/login_widget.dart';
import 'package:cyv/views/widgets/login/text_login_widget.dart';
import 'package:flutter/material.dart';
import 'confirmWidget.dart';

enum AuthMode { Login, Reset, Confirm }

class AuthForm extends StatefulWidget {
  @override
  _AuthFormStrState createState() => _AuthFormStrState();
}

class _AuthFormStrState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  void changeMode(AuthMode mode) {
    setState(() {
      _authMode = mode;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      Navigator.of(context).pushNamed(FaceRecognitionScreen.routeName);
    } else {
      int responseCode = await AuthCtr.resetPassword();
      if (responseCode == 200) {
        showErrorDialog(
            lang == "En"
                ? 'Check Your Email Inbox'
                : 'تفقد محتوى بريدك الالكترونى',
            context,
            title: 'Confirm');
      } else {
        showErrorDialog(
            lang == "En"
                ? 'Wrong Email or Not Exist!'
                : 'الايميل غير صحيح أو غير موجود',
            context);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              _authMode == AuthMode.Login
                  ? LoginWidget(changeMode)
                  : _authMode == AuthMode.Reset
                      ? EmailWidget()
                      : ConfirmWidget(),
              SizedBox(
                height: 20,
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : AuthButtonWidget(_authMode, changeMode, _submit),
              TextLoginWidget(_authMode, changeMode)
            ])));
  }
}
