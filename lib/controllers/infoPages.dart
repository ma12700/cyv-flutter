import 'dart:convert';
import 'package:cyv/controllers/auth.dart';
import 'package:cyv/models/infoPages.dart';
import 'package:cyv/models/user.dart';
import 'package:http/http.dart' as http;

class InfoPagesCtr {
  static Future<bool> fetchPages() async {
    try {
      var url = Uri.parse(AuthCtr.baseUrl + 'infoPage/getPage');
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
      var data = json.decode(response.body);
      InfoPageModel.storePages(data);
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return true;
  }
}
