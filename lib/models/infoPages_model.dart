import 'dart:convert';
import 'package:cyv/models/user_model.dart';
import 'package:http/http.dart' as http;

class Input {
  final String type;
  final String content;

  Input(this.type, this.content);
}

class Page {
  final String name;
  final String mainImg;
  final List<Input> pageContents;

  Page(this.name, this.mainImg, this.pageContents);
}

String paragraph =
    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.';

class InfoPageModel {
  static List<Page> pages = [];

  static Future<bool> fetchPages() async {
    try {
      pages.clear();
      var url = Uri.parse('https://e-votingfci.herokuapp.com/infoPage/getPage');
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
      var data = json.decode(response.body);
      data.forEach((page) {
        pages.add(Page(
          page['name'],
          page['image'],
          (page['content'] as List<dynamic>)
              .map((input) => Input(input['type'], input['value']))
              .toList(),
        ));
      });
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return true;
  }
}
