import 'package:cyv/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

void showErrorDialog(String message, BuildContext context,
    {String title = 'An Error Occurred!', bool backToHome = false}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
            if (backToHome) {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }
          },
        )
      ],
    ),
  );
}
