import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  static String id;
  static String type;
  static String name;
  static String img;
  static String nid;
  static String email;
  static String password;
  static bool isCandidature;
  static String etherumAddress;
  static String token;
  static String program = "";
  static String facebookURL = "";
  static String twitterURL = "";
  static final String baseUrl = 'https://e-votingfci.herokuapp.com/';
  static Map<String, dynamic> otherAttributes;

  static Future<int> login(File file) async {
    var url = Uri.parse(baseUrl + 'auth/login');
    var stream = new http.ByteStream(file.openRead());
    stream.cast();
    var length = await file.length();

    var request = new http.MultipartRequest("POST", url);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: file.path.split('/').last,
        contentType: new MediaType('image', file.path.split('.').last));

    request.files.add(multipartFile);
    request.fields
        .addAll({"email": "mohammed@gmail.com", "password": "123456"});
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    return response.statusCode;
    /* var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": "mohammed@gmail.com",
        "password": "123456"
      }),
    );
    token = response.headers['x-auth-token'];
    if (token == null) {
      throw Exception();
    }
    url = Uri.parse(baseUrl + 'user/getMe');
    response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': token
    });
    var data = json.decode(response.body) as Map<String, dynamic>;
    img = data['image'];
    name = data['name'];
    type = data['type'];
    nid = data['nationalID'];
    id = data['_id'];
    isCandidature = data['isCandidature'];
    etherumAddress = data['etherumAddress'];
    otherAttributes = data['statistics'][0]; */
  }

  static Future<int> resetPassword() async {
    var url = Uri.parse(baseUrl + 'auth/forgetPassword');
    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response.statusCode;
  }

  static Future<bool> fetchProgram() async {
    try {
      var url = Uri.parse(baseUrl + 'candidate/me');
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
      var data = json.decode(response.body);
      program = data['program'];
      facebookURL = data['facebookURL'];
      twitterURL = data['twitterURL'];
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return true;
  }
}
