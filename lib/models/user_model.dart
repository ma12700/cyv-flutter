import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Attribute {
  final String key;
  final bool update;
  final List<String> values;
  String answer = "";

  Attribute(this.key, this.update, this.values, this.answer);
}

class User {
  static String id;
  static String type;
  static String name;
  static String img;
  static String nid;
  static String email;
  static bool state;
  static String password;
  static bool isCandidature;
  static String etherumAddress;
  static String token;
  static String program = "";
  static String facebookURL = "";
  static String twitterURL = "";
  static final String baseUrl = 'https://e-votingfci.herokuapp.com/';
  static String time = "Result";
  static Map<String, dynamic> otherAttributes = {};
  static List<Attribute> attributesValues = [];

  static Future<void> login(File file, Function onComplete) async {
    var url = Uri.parse(baseUrl + 'auth/login');
    var stream = new http.ByteStream(file.openRead());
    stream.cast();
    var length = await file.length();

    var request = new http.MultipartRequest("POST", url);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: file.path.split('/').last,
        contentType: new MediaType('image', file.path.split('.').last));

    request.files.add(multipartFile);
    request.fields.addAll({"email": email, "password": password});
    String resultString = "";
    await request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          token = response.headers['x-auth-token'];
          type = data["user"]['type'];
          isCandidature = data["user"]['isCandidature'];
          state = data["user"]['state'];
          id = data["user"]['_id'];
          img = data["user"]['image'];
          name = data["user"]['name'];
          nid = data["user"]['nationalID'];
          etherumAddress = data["user"]['etherumAddress'];
          (data["user"]['statistics'] as List<dynamic>).forEach((attribute) {
            var attr = attribute as Map<String, dynamic>;
            otherAttributes[attr['key']] = attr['value'];
          });
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

  static Future<bool> getMe() async {
    var url = Uri.parse(baseUrl + 'user/getMe');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    final Map<String, dynamic> data = json.decode(response.body);
    type = data['type'];
    isCandidature = data['isCandidature'];
    state = data['state'];
    id = data['_id'];
    img = data['image'];
    name = data['name'];
    nid = data['nationalID'];
    etherumAddress = data['etherumAddress'];
    attributesValues = [];
    (data['statistics'] as List<dynamic>).forEach((attribute) {
      var attr = attribute as Map<String, dynamic>;
      var values =
          (attr['values'] as List<dynamic>).map((e) => e.toString()).toList();
      otherAttributes[attr['key']] = attr['value'];

      try {
        attributesValues
            .add(Attribute(attr['key'], attr['update'], values, attr['value']));
      } catch (e) {
        print('here : ' + e);
      }
    });
    return true;
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
