import 'package:cyv/models/infoPages_model.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/screens/page_content_screen.dart';
import 'package:flutter/material.dart';

class PagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: InfoPageModel.pages.length,
          itemBuilder: (context, index) {
            var page = InfoPageModel.pages[index];
            print(page.mainImg);
            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(PageContentScreen.routeName, arguments: index);
              },
              child: Card(
                elevation: 14.0,
                shape: Border.all(
                  color: Style.borderColor,
                  width: 4,
                ),
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Image.network(
                          page.mainImg,
                          width: double.infinity,
                          // height: 390,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Style.primaryColor),
                          child: Center(
                            child: Text(page.name,
                                style: TextStyle(
                                    shadows: [
                                      BoxShadow(
                                        color: Style.nullColor,
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 0),
                                      )
                                    ],
                                    color: Style.lightColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          }),
    );
  }
}
