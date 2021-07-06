import 'dart:convert';
import 'package:cyv/controllers/auth.dart';
import 'package:cyv/models/user.dart';
import 'package:http/http.dart' as http;

class UserCtr {
  static Future<bool> fetchProgram() async {
    try {
      var url = Uri.parse(AuthCtr.baseUrl + 'candidate/me');
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
      var data = json.decode(response.body);
      User.storeProgramData(data);
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return true;
  }

  static Future<bool> updateData() async {
    var url = Uri.parse(AuthCtr.baseUrl + 'user/getMe');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    final Map<String, dynamic> data = json.decode(response.body);
    User.updateData(data);
    return true;
  }

  static Future<int> updateStatistics() async {
    final statistics = User.attributesValues.map((attr) {
      if (attr.update) {
        return {attr.key: attr.answer};
      }
    }).toList();
    var url = Uri.parse(AuthCtr.baseUrl + 'user/updateStatistics');
    final response = await http.put(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    }, body: {
      "statistics": statistics
    });
    return response.statusCode;
  }
}
