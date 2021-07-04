import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user_model.dart';
import 'package:cyv/views/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final Function select;
  AppDrawer(this.select);
  @override
  Widget build(BuildContext context) {
    return Drawer(
        // container of all drawer content
        child: Container(
            color: Style.backgroundColor,
            child: Column(children: [
              //the upper part
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    bottom: 20, top: 50, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  color: Style.primaryColor,
                ),
                child: Column(
                  children: [
                    // User image
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(User.img), fit: BoxFit.fill)),
                    ),
                    //user name
                    Text(
                      User.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Style.lightColor,
                      ),
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    // user type
                    Text((lang == 'En' ? User.type : dictionary[User.type]),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Style.darkColor)),
                  ],
                ),
              ),
              // choices of drawer
              Expanded(
                  child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                children: [
                  choiceWidget(Icons.home, "Home", context),
                  choiceWidget(Icons.group, "Candidates", context),
                  choiceWidget(Icons.recent_actors, "Cnadidature", context),
                  choiceWidget(Icons.warning, "Waiving", context),
                  choiceWidget(Icons.contacts, "Voting", context),
                  choiceWidget(Icons.insert_chart, "Result", context),
                  choiceWidget(Icons.insert_chart, "statistics", context),
                  choiceWidget(Icons.person, "My profile", context),
                  choiceWidget(Icons.help, "Help", context),
                ],
              )),
              Divider(
                thickness: 4,
                color: Style.primaryColor,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child:
                    choiceWidget(Icons.power_settings_new, "Log Out", context),
              )
            ])));
  }

  Widget choiceWidget(IconData icon, String text, BuildContext context) {
    return InkWell(
      onTap: () {
        if (text != 'Log Out') {
          select(text);
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        }
      },
      child: Container(
          padding: EdgeInsets.all(12),
          child: Row(children: [
            Icon(
              icon,
              color: Style.secondColor,
              size: 27,
            ),
            SizedBox(
              width: 18,
            ),
            Text(
              (lang == 'En' ? text : dictionary[text]),
              style: TextStyle(color: Style.darkColor, fontSize: 20),
            ),
          ])),
    );
  }
}
