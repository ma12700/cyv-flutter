import 'dart:convert';
import 'package:cyv/models/user_model.dart';
import 'package:http/http.dart' as http;

class Requirement {
  final String title;
  final String type;
  final List<String> values;

  Requirement(this.title, this.type, this.values);
}

class RequirementsModel {
  static List<Requirement> requirements = [];
  static List<Map<String, dynamic>> request = [];

  static Future<bool> fetchRequirements() async {
    try {
      requirements.clear();
      var url = Uri.parse(User.baseUrl + 'requirement/getRequirement');
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
      var data = json.decode(response.body);
      data[0]['requirements'].forEach((requirement) {
        requirements.add(Requirement(
            requirement['title'], requirement['type'], requirement['values']));
      });
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return true;
  }
}
