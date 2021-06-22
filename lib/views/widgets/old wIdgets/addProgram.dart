import 'package:flutter/material.dart';

class AddProgram extends StatefulWidget {
  final Function back;
  AddProgram(this.back);
  _AddProgramState createState() => _AddProgramState();
}

class _AddProgramState extends State<AddProgram> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'program': '', 'facebook': '', 'twitter': ''};

  void submit() {
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            inputWidget(20, "Write Your Election Program", "program"),
            ListTile(
              leading: Image.asset('assets/images/facebook.png'),
              title: inputWidget(1, 'Facebook Url', 'facebook'),
            ),
            ListTile(
              leading: Image.asset('assets/images/twitter.png'),
              title: inputWidget(1, 'Twitter Url', 'twitter'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: widget.back, child: Text('Back')),
                ElevatedButton(
                  onPressed: submit,
                  child: Text('Save'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget inputWidget(int lines, String hint, String saveIn) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2)),
      child: TextFormField(
        maxLines: lines,
        keyboardType: TextInputType.text,
        autofocus: false,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
        onSaved: (value) {
          formData[saveIn] = value;
        },
      ),
    );
  }
}
