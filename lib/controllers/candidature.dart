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
    print(data);
    RequirementsModel.storeRequirements(data);
    return true;
  }

  //send images with requirements
  static Future<void> sendRequest(String trackID) async {
    var url = Uri.parse(AuthCtr.baseUrl + 'request/addRequest/' + trackID);
    var request = new http.MultipartRequest("POST", url);

    RequirementsModel.requirements.forEach((require) async {
      if (require.type == "Image") {
        var stream = new http.ByteStream(require.file.openRead());
        stream.cast();
        var length = await require.file.length();
        var multipartFile = new http.MultipartFile('file', stream, length,
            filename: require.file.path.split('/').last,
            contentType:
                new MediaType('image', require.file.path.split('.').last));

        request.files.add(multipartFile);
      } else {
        //request.fields.addAll({"email": User.email, "password": User.password});
      }
    });

    request.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });

    await request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
        }
      });
    }).catchError((err) {});
  }
}
