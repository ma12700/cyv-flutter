import 'package:cyv/views/widgets/dialog.dart';
import 'package:cyv/models/language.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialWidget extends StatelessWidget {
  final String img, url;

  const SocialWidget({Key key, this.img, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          showErrorDialog(
              lang == "En"
                  ? "'Could not launch this URL"
                  : "التطبيق لا ييستطيع فتح هذا الرابط",
              context);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        width: 30,
        height: 40,
        decoration: BoxDecoration(

            // shape: BoxShape.rectangle,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/" + img + ".png",
                ),
                fit: BoxFit.fill)),
      ),
    );
  }
}
