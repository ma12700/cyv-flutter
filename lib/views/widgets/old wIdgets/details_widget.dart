import 'package:cyv/models/user_model.dart';
import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  final Function program;
  DetailsWidget(this.program);
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      attributeWidget("National ID", User.nid),
      ...User.otherAttributes.entries.map((attribute) {
        return attributeWidget(attribute.key, attribute.value.toString());
      }).toList(),
      if (User.type == "Candidate")
        Container(
          width: double.infinity,
          child: Center(
            child: ElevatedButton(
              onPressed: program,
              child: Text(
                'Your Program',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        )
    ]);
  }

  Widget attributeWidget(String attribute, String value) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(attribute + ":",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black)),
          Text(
            value,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
