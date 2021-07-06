import 'dart:convert';
import 'package:cyv/controllers/auth.dart';
import 'package:cyv/models/requirements.dart';
import 'package:cyv/models/user.dart';
import 'package:http/http.dart' as http;

class CandidatureCtr {
  static Future<bool> fetchRequirements() async {
    var url = Uri.parse(AuthCtr.baseUrl + 'requirement/getRequirement');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    var data = json.decode(response.body);
    print(data);
    RequirementsModel.storeRequirements(data);
    return true;
  }

  //send images with requirements
  static Future<bool> sendRequest(String trackID) async {
    var url = Uri.parse(AuthCtr.baseUrl + 'request/addRequest/' + trackID);
    final response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    }, body: {});
    var data = json.decode(response.body);
    return true;
  }
}
