import 'dart:convert';
import 'dart:io';
import 'package:cyv/models/user_model.dart';
import 'package:http/http.dart' as http;

class Requirement {
  final String title;
  final String type;
  final List<String> values;
  String answer = "";
  File file;
  Requirement(this.title, this.type, this.values, this.answer);
}

class RequirementsModel {
  static List<Requirement> requirements = [];
  static List<Map<String, dynamic>> request = [];

  static Future<bool> fetchRequirements() async {
    requirements.clear();
    var url = Uri.parse(User.baseUrl + 'requirement/getRequirement');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    var data = json.decode(response.body);
    (data[0]['requirements'] as List<dynamic>).forEach((requirement) {
      var values = (requirement['values'] as List<dynamic>)
          .map((el) => el as String)
          .toList();
      requirements.add(Requirement(
          requirement['title'],
          requirement['type'],
          (values.isEmpty ? [] : values),
          (values.isNotEmpty && requirement['type'] == "Select"
              ? values[0]
              : "")));
    });
    return true;
  }

  static Future<bool> sendRequirements() async {
    requirements.clear();
    var url = Uri.parse(User.baseUrl + 'requirement/getRequirement');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    var data = json.decode(response.body);
    (data[0]['requirements'] as List<dynamic>).forEach((requirement) {
      var values = (requirement['values'] as List<dynamic>)
          .map((el) => el as String)
          .toList();
      requirements.add(Requirement(
          requirement['title'],
          requirement['type'],
          (values.isEmpty ? [] : values),
          (values.isNotEmpty && requirement['type'] == "Select"
              ? values[0]
              : "")));
    });
    return true;
  }
}
