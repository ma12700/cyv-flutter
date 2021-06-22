import 'package:flutter/material.dart';

class SocialWidget extends StatelessWidget {
  final String img, url;

  const SocialWidget({Key key, this.img, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('hcgjhkk');
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
