import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';
// import 'package:flutterchallenge/countrylist.dart';
import '../../models/dataa.dart';
import 'package:cyv/views/widgets/app_bar_widget.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Color Converter
_hexToColor(String code) =>
    Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

//InputValidators
_ifNull(val) => val == null ? "Value is null" : "Value is empty";

//TextStyle
_textStyle() => TextStyle(color: _hexToColor("#F2A03D"), fontSize: 14.0);

//InputDecoration
_inputDecoration(label) => InputDecoration(
    labelText: label,
    fillColor: Style.lightColor,
    border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(18.0),
        borderSide: new BorderSide()));

//InputDecoration with suffix icon
_inputWithSuffixDecoration(label, suffixIcon) => InputDecoration(
    labelText: label,
    fillColor: Style.lightColor,
    suffixIcon: suffixIcon,
    border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(18.0),
        borderSide: new BorderSide()));

//InputNameText field
_inputNameField() => TextFormField(
      decoration: _inputDecoration("User Name"),
      validator: (val) => _ifNull(val),
      style: _textStyle(),
    );

//InputPasswordText field
_inputPasswordField(bool show, handleShowHidePassword) => TextFormField(
      decoration: _inputWithSuffixDecoration(
          "Password",
          IconButton(
            icon: show ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: () => handleShowHidePassword(show),
          )),
      obscureText: show,
      validator: (val) => _ifNull(val),
      style: _textStyle(),
    );
//imageInputField
_addPhotdeImage(_storedImage, _takePicture) => Container(
        child: Column(children: [
      Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: _storedImage != null
                  ? Image.file(
                      _storedImage,
                      fit: BoxFit.fill,
                    )
                  : Container(),
              margin: EdgeInsets.all(20),
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Style.darkColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13, right: 20),
              child: Text("Personal Image"),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Icon(Icons.camera_alt),
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                      onTap: () {
                        _takePicture();
                      },
                      child: Text("Add")))
            ])
          ])
    ]));

//EmailInputField
_emailInputField() => TextFormField(
      decoration: _inputDecoration("Email"),
      validator: (val) => _ifNull(val),
      style: _textStyle(),
      keyboardType: TextInputType.emailAddress,
    );

//Phone Number
_phoneInputField() => TextFormField(
      decoration: _inputDecoration("Phone Number"),
      validator: (val) => _ifNull(val),
      style: _textStyle(),
      keyboardType: TextInputType.phone,
    );

//Address
_addressInputFiled() => TextFormField(
      decoration: _inputDecoration("Adresss"),
      validator: (val) => _ifNull(val),
      style: _textStyle(),
      maxLines: 5,
      keyboardType: TextInputType.text,
    );

//Radio button (Gender)
_genderRadio(int groupValue, handleRadioValueChanged) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Text(
        'Gender',
        style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      Row(
        children: <Widget>[
          Radio(
              value: 0,
              groupValue: groupValue,
              onChanged: handleRadioValueChanged),
          Text(
            "Male",
            style: new TextStyle(
              fontSize: 14.0,
            ),
          ),
          Radio(
              value: 1,
              groupValue: groupValue,
              onChanged: handleRadioValueChanged),
          Text(
            "Female",
            style: new TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      )
    ]);

//Spinner Country
_countryWidget(currentCountry, changedDropDownItem) => new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Text(
          "Choose your country: ",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        new DropdownButton(
          value: currentCountry,
          items: List<String>.from(countryList)
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(width: 200, child: Text(value)),
            );
          }).toList(),
          onChanged: changedDropDownItem,
        )
      ],
    );

//CheckBoxes(Education)
_checkbox(title, int index, bool boolValue, handleCheckBox) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Checkbox(
        value: boolValue,
        onChanged: (bool value) {
          boolValue = value;
          handleCheckBox(index, boolValue);
        },
      ),
      Text(title),
    ],
  );
}

//Submit(Raised Button)
_submitForm() => Container(
      width: 120,
      child: ElevatedButton(
          onPressed: () {},
          child: Text("Next"),
          style: ElevatedButton.styleFrom(
            primary: Style.primaryColor,
          )),
    );

//Reset(Cancel)
_resetForm() => ElevatedButton.icon(
    onPressed: () {},
    icon: Icon(Icons.close),
    label: Text("Reset Form"),
    style: ElevatedButton.styleFrom(
      primary: Style.primaryColor,
    ));

class Forms extends StatefulWidget {
  static const routeName = 'Candidature form';
  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  List eduSelection = [false, false, false, false];
  String currentCountry = "Nepal";
  int _groupValue = -1;
  bool _show = true;
  File _storedImage;
  void setLanguage() {
    setState(() {
      lang = lang == "En" ? "ع" : "En";
      direction = lang == "En" ? TextDirection.ltr : TextDirection.rtl;
    });
  }

  Future<void> _takePicture() async {
    // ignore: deprecated_member_use
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    /* final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path); */
    // ignore: unused_local_variable
    //final savedImage = await imageFile.copy('${appDir.path}/$fileName');
  }
  // bool _accept = true;

  void _handleCheckBox(int index, bool isActive) {
    setState(() {
      this.eduSelection[index] = isActive;
    });
  }

  void _changedDropDownItem(value) {
    setState(() {
      this.currentCountry = value;
    });
  }

  void _handleRadioValueChanged(int value) {
    setState(() {
      this._groupValue = value;
    });
  }

  void _handleShowHidePassword(bool show) {
    setState(() {
      this._show = !show;
    });
  }

  // void _onSwitchChanged(bool accept) {
  //   setState(() {
  //     this._accept = accept;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: (lang == "En" ? TextDirection.ltr : TextDirection.rtl),
        child: Scaffold(
          appBar: appBarWidget(setLanguage, title: "Form"),
          body: Stack(
            children: [
              //top design
              _buildIamge(),
              _buildIamge2(),
              //student union
              _buildIamge4(),

              // padding: EdgeInsets.all(8.0),
              Container(
                padding: const EdgeInsets.only(top: 200, left: 10, right: 10),
                child: ListView(
                  children: <Widget>[
                    _inputNameField(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _inputPasswordField(_show, _handleShowHidePassword),
                    SizedBox(
                      height: 8.0,
                    ),
                    _emailInputField(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _phoneInputField(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _addPhotdeImage(_storedImage, _takePicture),
                    _addressInputFiled(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _countryWidget(currentCountry, _changedDropDownItem),
                    SizedBox(
                      height: 8.0,
                    ),
                    _genderRadio(_groupValue, _handleRadioValueChanged),
                    Text("Select Education",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8.0,
                    ),
                    _checkbox("School", 0, eduSelection[0], _handleCheckBox),
                    _checkbox("Higher education grades", 1, eduSelection[1],
                        _handleCheckBox),
                    _checkbox(
                        "Undergraduate", 2, eduSelection[2], _handleCheckBox),
                    _checkbox(
                        "Post Graduate", 3, eduSelection[3], _handleCheckBox),
                    SizedBox(
                      height: 8.0,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: <Widget>[
                    //     Text("Love this flutter form",
                    //         style: TextStyle(
                    //             fontSize: 16.0, fontWeight: FontWeight.bold)),
                    //     _acceptSwitch(_accept, _onSwitchChanged),
                    //   ],
                    // ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [_submitForm(), _resetForm()])
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

Widget _buildIamge() {
  return new Positioned.fill(
      bottom: null,
      child: new ClipPath(
        clipper: new DialogonalClipper2(),
        child: Container(
          color: Style.secondColor,
          height: 200,
        ),
      ));
}

Widget _buildIamge2() {
  return new Positioned.fill(
      bottom: null,
      child: new ClipPath(
        clipper: new DialogonalClipper(),
        child: Container(
          // padding: EdgeInsets.only(bottom: 30),
          color: Style.primaryColor,
          height: 200,
        ),
      ));
}

Widget _buildIamge4() {
  return Padding(
      padding: const EdgeInsets.only(left: 60, top: 30),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 30),
            child: Text(
              "Student Union",
              style: TextStyle(
                  shadows: [
                    BoxShadow(
                      color: Style.primaryColor,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    )
                  ],
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Style.darkColor),
            ),
          ),
          Image.asset(
            "assets/images/formcand.png",
            fit: BoxFit.cover,
          )
        ],
      ));
}

class DialogonalClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 170);
    var controllPoint = Offset(
      size.height,
      50,
    );
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 170);
    var controllPoint = Offset(
      size.height,
      30,
    );
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
