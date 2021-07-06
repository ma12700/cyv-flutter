import 'dart:convert';
import 'dart:io';

import 'package:cyv/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AuthCtr {
  static final String baseUrl = 'https://e-votingfci.herokuapp.com/';

  static Future<void> login(File file, Function onComplete) async {
    var url = Uri.parse(baseUrl + 'auth/login');
    var stream = new http.ByteStream(file.openRead());
    stream.cast();
    var length = await file.length();
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: file.path.split('/').last,
        contentType: new MediaType('image', file.path.split('.').last));

    var request = new http.MultipartRequest("POST", url);
    request.files.add(multipartFile);
    request.fields.addAll({"email": User.email, "password": User.password});

    String resultString = "";
    await request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          User.token = response.headers['x-auth-token'];
          User.storeUserData(data);
          resultString = "matched";
        } else if (response.statusCode == 404) {
          resultString = "Wrong Email or Password";
        } else {
          final Map<String, dynamic> data = json.decode(response.body);
          resultString = data['result'];
        }
        onComplete(resultString);
      });
    }).catchError((err) {
      onComplete(err.toString());
    });
  }

  static Future<int> resetPassword() async {
    var url = Uri.parse(baseUrl + 'auth/forgetPassword');
    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response.statusCode;
  }
}
