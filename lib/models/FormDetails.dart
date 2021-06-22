import 'dart:convert';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

enum InputType { Txt, Img, Number }

class Input {
  final InputType type;
  final String content;

  Input(this.type, this.content);
}

// class Page {
//   final String name;
//   final String mainImg;
//   final List<Input> pageContents;

//   Page(this.name, this.mainImg, this.pageContents);
// }

String paragraph =
    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.';

class InfoPageModel {
  static List<Input> pages = [
    Input(InputType.Txt, "Full Name"),
    Input(InputType.Number, "Phone number"),
    Input(InputType.Img, "personal picture"),
    Input(InputType.Number, "National ID"),
    Input(InputType.Img, "birth certificate"),
  ];

  static void fetchPages() async {
    var url = Uri.parse('');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      // sane data into pages variable
    } catch (error) {
      print(error.toString());
    }
  }
}
