import 'dart:async';
import 'dart:io';
import 'package:cyv/models/user_model.dart';
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

  @override
  Widget build(BuildContext context) {
    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    Future<void> _submit() async {
      /* if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save(); */
      setState(() {
        _isLoading = true;
      });
      try {
        if (_authMode == AuthMode.Login) {
          //await User.login();
          Navigator.of(context)
              .pushReplacementNamed(FaceRecognitionScreen.routeName);
        } else {
          // Sign user up
        }
        //Navigator.of(context)
        // .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      } on SocketException {
        _showErrorDialog('No Internet connection');
      } on TimeoutException catch (_) {
        _showErrorDialog('Connection timeout');
      } catch (e) {
        _showErrorDialog('$e');
      }

      setState(() {
        _isLoading = false;
      });
    }

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
