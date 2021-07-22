import 'dart:convert';
import 'package:cyv/controllers/auth.dart';
import 'package:cyv/models/requirements.dart';
import 'package:cyv/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CandidatureCtr {
  static Future<bool> fetchRequirements() async {
    var url = Uri.parse(AuthCtr.baseUrl + 'requirement/getRequirement');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    var data = json.decode(response.body);
    RequirementsModel.storeRequirements(data);
    return true;
  }

  //send images with requirements
  static Future<bool> sendRequest(String trackID) async {
    int counter = 0;
    var url = Uri.parse(AuthCtr.baseUrl + 'request/addRequest/' + trackID);
    var request = new http.MultipartRequest("POST", url);
    int length = RequirementsModel.requirements.length;
    for (int i = 0; i < length; i++) {
      var require = RequirementsModel.requirements[i];
      if (require.type == "Image") {
        var stream = new http.ByteStream(require.file.openRead());
        stream.cast();
        var length = await require.file.length();
        var multipartFile = new http.MultipartFile(
            require.title, stream, length,
            filename: require.file.path.split('/').last,
            contentType:
                new MediaType('image', require.file.path.split('.').last));

        request.files.add(multipartFile);
      } else {
        request.fields["values[" + counter.toString() + "]"] =
            '{"key": "${require.title}", "value": "${require.answer}"}';
        i++;
      }
    }
    request.headers.addAll({'x-auth-token': User.token});

    var response = await request.send();
    return response.statusCode == 201;
  }
}
