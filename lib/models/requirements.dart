import 'dart:io';

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

  static void storeRequirements(Map<String, dynamic> data) async {
    requirements.clear();
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
  }
}
