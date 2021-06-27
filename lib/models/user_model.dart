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
  static Map<String, dynamic> otherAttributes;
  static login() async {
    var url = Uri.parse('https://e-votingfci.herokuapp.com/auth/login');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": "ahmedeid6842@gmail.com",
        "password": "aPassword123!"
      }),
    );
    token = response.headers['x-auth-token'];
    if (token == null) {
      throw Exception();
    }
    url = Uri.parse('https://e-votingfci.herokuapp.com/user/getMe');
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
    otherAttributes = data['statistics'][0];
  }
}
