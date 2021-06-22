import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';
// import '../../models/FormDetails.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
/* import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths; */
import '../../models/dataa.dart';

//InputValidators
_ifNull(val) => val == null ? "Value is null" : "Value is empty";

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
      // style: _textStyle(),
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
      // style: _textStyle(),
    );

//EmailInputField
_emailInputField() => TextFormField(
      decoration: _inputDecoration("Email"),
      validator: (val) => _ifNull(val),
      // style: _textStyle(),
      keyboardType: TextInputType.emailAddress,
    );

//Phone Number
_phoneInputField() => TextFormField(
      decoration: _inputDecoration("Phone Number"),
      validator: (val) => _ifNull(val),
      // style: _textStyle(),
      keyboardType: TextInputType.phone,
    );

//Address
_addressInputFiled() => TextFormField(
      decoration: _inputDecoration("Adresss"),
      validator: (val) => _ifNull(val),
      // style: _textStyle(),
      maxLines: 5,
      keyboardType: TextInputType.text,
    );
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
              width: 100,
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

//Radio button (Gender)
_genderRadio(int groupValue, handleRadioValueChanged) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Text(
        'Gender',
        style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Row(
        children: <Widget>[
          Radio(
              activeColor: Style.secondColor,
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
              activeColor: Style.secondColor,
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
          "Choose the Track: ",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        new DropdownButton(
          value: currentCountry,
          items: List<String>.from(countryList).map<DropdownMenuItem<String>>((
            String value,
          ) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                width: 200,
                child: Text(value),
              ),
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
        activeColor: Style.secondColor,
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
_submitForm() => ElevatedButton(
      style:
          ButtonStyle(backgroundColor: Style.buttonColor(Style.primaryColor)),
      onPressed: () {},
      child: Text("Submit Form"),
    );

//Reset(Caancel)
_resetForm() => ElevatedButton.icon(
    style: ButtonStyle(backgroundColor: Style.buttonColor(Style.primaryColor)),
    onPressed: () {},
    icon: Icon(Icons.close),
    label: Text("Reset Form"));

class FormData extends StatefulWidget {
  static const routeName = 'Candidature form Data';
  @override
  _FormDataState createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  List eduSelection = [false, false, false, false];
  String currentCountry = "Scientific track";
  int _groupValue = -1;
  bool _show = true;
  File _storedImage;
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

  final focuson = FocusNode();

  TextStyle textStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Style.primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: new Stack(
          //overflow: Overflow.clip,
          // overflow: Overflow.visible,
          children: <Widget>[
            _buildIamge(),
            _buildIamge2(),
            _buildIamge4(),
            _buildIamge3(),
            // _buildIamge5()
          ],
        ),
      ),
    );
  }

  Widget _buildIamge() {
    return new Positioned.fill(
        bottom: null,
        child: new ClipPath(
          clipper: new DialogonalClipper2(),
          child: Container(
            color: Style.secondColor,
            height: 430,
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
            height: 430,
          ),
        ));
  }

  Widget _buildIamge4() {
    return Padding(
        padding: const EdgeInsets.only(left: 60, top: 30),
        child: Row(
          children: [
            Container(
              // padding: EdgeInsets.only(right: 30),
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

  Widget _buildIamge3() {
    return Container(
        height: 600,
        padding: const EdgeInsets.only(top: 200, left: 10, right: 10),
        // padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            _inputNameField(),
            SizedBox(
              height: 12,
            ),
            _inputPasswordField(_show, _handleShowHidePassword),
            SizedBox(
              height: 12,
            ),
            _emailInputField(),
            SizedBox(
              height: 12,
            ),
            _addPhotdeImage(_storedImage, _takePicture),
            _phoneInputField(),
            SizedBox(
              height: 12,
            ),
            _addressInputFiled(),
            SizedBox(
              height: 12,
            ),
            _countryWidget(currentCountry, _changedDropDownItem),
            SizedBox(
              height: 12,
            ),
            _genderRadio(_groupValue, _handleRadioValueChanged),
            Text("Select Level",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 12,
            ),
            _checkbox("Level one ", 0, eduSelection[0], _handleCheckBox),
            _checkbox("Level two", 1, eduSelection[1], _handleCheckBox),
            _checkbox("Level three", 2, eduSelection[2], _handleCheckBox),
            _checkbox("Level foure", 3, eduSelection[3], _handleCheckBox),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [_submitForm(), _resetForm()])
          ],
        ));
  }
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
