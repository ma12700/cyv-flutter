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

class InfoPageModel {
  static List<Page> pages = [];

  static void storePages(List<dynamic> data) async {
    pages.clear();
    data.forEach((page) {
      pages.add(Page(
        page['name'],
        page['image'],
        (page['content'] as List<dynamic>)
            .map((input) => Input(input['type'], input['value']))
            .toList(),
      ));
    });
  }
}
