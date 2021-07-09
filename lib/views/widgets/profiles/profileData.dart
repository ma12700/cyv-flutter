import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:cyv/views/widgets/profiles/taskrow.dart';
import 'package:flutter/material.dart';

class ProfileDataWidget extends StatelessWidget {
  static int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TaskRow((lang == 'En' ? 'Name' : dictionary['Name']), User.name,
            Style.primaryColor),
        TaskRow((lang == 'En' ? 'Email' : dictionary['Email']), User.email,
            Style.secondColor),
        TaskRow((lang == 'En' ? 'National ID' : dictionary['National ID']),
            User.nid, Style.primaryColor),
        ...User.otherAttributes.entries.map((e) {
          index = (index + 1) % 2;
          return TaskRow(
            e.key,
            e.value,
            index == 1 ? Style.secondColor : Style.primaryColor,
          );
        }).toList(),
      ],
    );
  }
}
