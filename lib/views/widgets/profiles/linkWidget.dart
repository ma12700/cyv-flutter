import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:flutter/material.dart';

class LinkWidget extends StatefulWidget {
  final bool isFacebook;
  LinkWidget(this.isFacebook);
  _LinkWidgetState createState() => _LinkWidgetState();
}

class _LinkWidgetState extends State<LinkWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 0),
            )
          ],
          color: Style.lightColor,
          border: Border.all(
            width: 2,
            color: Style.darkColor,
          )),
      child: Container(
        height: 100,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              width: 30,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        widget.isFacebook
                            ? "assets/images/facebook.png"
                            : "assets/images/twitter.png",
                      ),
                      fit: BoxFit.fill)),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextFormField(
                minLines: 1,
                maxLines: 1,
                initialValue:
                    widget.isFacebook ? User.facebookURL : User.twitterURL,
                onChanged: (value) {
                  widget.isFacebook
                      ? User.facebookURL = value
                      : User.twitterURL = value;
                },
                validator: (value) {
                  if (value != "") {
                    if (widget.isFacebook &&
                        !User.facebookURL
                            .startsWith('https://www.facebook.com/')) {
                      return lang == "En"
                          ? "Enter valid Facebook Link"
                          : "أدخل رابط فيسبوك صحيح";
                    } else {
                      if (!widget.isFacebook &&
                          !User.twitterURL
                              .startsWith('https://www.twitter.com/')) {
                        return lang == "En"
                            ? "Enter valid twitter Link"
                            : "أدخل رابط تويتر صحيح";
                      }
                    }
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: widget.isFacebook
                        ? (lang == "En" ? "Facebook Url" : "رابط فيسبوك")
                        : (lang == "En" ? "Twitter Url" : "رابط تويتر"),
                    hintStyle: TextStyle(
                      color: Style.nullColor,
                    ),
                    border: InputBorder.none),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
