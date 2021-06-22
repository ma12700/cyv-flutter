import 'package:cyv/models/infoPages_model.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class PageContentScreen extends StatefulWidget {
  static const routeName = '/pageContent';
  PageContentScreenState createState() => PageContentScreenState();
}

class PageContentScreenState extends State<PageContentScreen> {
  void setLanguage() {
    setState(() {
      lang = lang == "En" ? "ع" : "En";
      direction = lang == "En" ? TextDirection.ltr : TextDirection.rtl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int pageIndex = ModalRoute.of(context).settings.arguments;
    return Directionality(
      textDirection: (lang == "En" ? TextDirection.ltr : TextDirection.rtl),
      child: Scaffold(
        appBar: appBarWidget(setLanguage,
            title: InfoPageModel.pages[pageIndex].name),
        backgroundColor: Style.backgroundColor,
        body: ListView.builder(
            itemCount: InfoPageModel.pages[pageIndex].pageContents.length,
            itemBuilder: (context, index) {
              Input input = InfoPageModel.pages[pageIndex].pageContents[index];

              // check the type of content and return corresponding design
              // title,paragraph,image
              switch (input.type) {
                // title design
                case 'title':
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      input.content,
                      style: TextStyle(
                          shadows: [
                            BoxShadow(
                              color: Style.primaryColor,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            )
                          ],
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Style.secondColor),
                    ),
                  );
                // image desin
                case 'image':
                  return Container(
                      margin: EdgeInsets.only(
                          bottom: 20, top: 20, left: 12, right: 12),
                      height: 340,
                      width: double.infinity,
                      child: Image.network(
                        input.content,
                      ));
                // paragraph design
                case 'paragraph':
                  return Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Style.lightColor,
                        boxShadow: [
                          BoxShadow(
                            color: Style.primaryColor,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 0),
                          )
                        ],
                        border: Border.all(width: 2, color: Style.borderColor)),
                    child: Text(
                      input.content,
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.5,
                        // fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
              }
              return Container();
            }),
      ),
    );
  }
}
