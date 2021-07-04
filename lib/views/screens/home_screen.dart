import 'package:cyv/models/candidates_model.dart';
import 'package:cyv/models/infoPages_model.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/requirements_model.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user_model.dart';
import 'package:cyv/views/widgets/app_bar_widget.dart';
import 'package:cyv/views/widgets/candidature.dart';
import 'package:cyv/views/widgets/tracks_widget.dart';
import '../widgets/help_widget.dart';
import '../widgets/vote_widget.dart';
import 'package:cyv/views/widgets/drawer_widget.dart';
import 'package:cyv/views/widgets/info_pages_widget.dart';
import 'package:cyv/views/widgets/waive_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/my_profile_widget.dart';
import '../widgets/statistics.dart';
import '../../models/series_data.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String bodywidget = 'Home';
  int barIndex = 0;
  void changeBody(String value) {
    if (bodywidget != value) {
      setState(() {
        bodywidget = value;
        barIndex = 0;
      });
    }
  }

  void setLanguage() {
    setState(() {
      lang = lang == "En" ? "ع" : "En";
      direction = lang == "En" ? TextDirection.ltr : TextDirection.rtl;
    });
  }

  Widget future(Function future, Widget screen) {
    return FutureBuilder(
        future: future(),
        builder: (ctx, fetchResultSnapshot) =>
            fetchResultSnapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : screen);
  }

  Widget bodyWidget() {
    switch (bodywidget) {
      case 'Home':
        return InfoPageModel.pages.isNotEmpty
            ? PagesWidget()
            : future(InfoPageModel.fetchPages, PagesWidget());
      case 'Candidates':
        return CandidatesModel.tracks.isNotEmpty
            ? TracksWidget()
            : future(CandidatesModel.fetchTracks, TracksWidget());
      case 'Cnadidature':
        return CandidatesModel.tracks.isNotEmpty
            ? TracksWidget()
            : future(CandidatesModel.fetchTracks, TracksWidget());
      case 'CnadidatureForm':
        return RequirementsModel.requirements.isNotEmpty
            ? CandidatureForm() //must be updated (is remining)
            : future(RequirementsModel.fetchRequirements, CandidatureForm());
      case 'Waiving':
        return WaiveWidget();
      case 'Voting':
        return future(CandidatesModel.fetchAll, VoteWidget());
      case 'Result':
        return CandidatesModel.tracks.isNotEmpty
            ? TracksWidget()
            : future(CandidatesModel.fetchTracks,
                TracksWidget()); //From Smart Contract
      case 'statistics':
        return Subscribechart(barIndex); //Waited for updating
      case 'My profile':
        return MyProfileWidget(barIndex);
      case 'Help':
        return HelpWidget();
      default:
        return Center();
    }
  }

  BottomNavigationBar bottomBar() {
    if (bodywidget == "statistics" && User.time == "Result") {
      return BottomNavigationBar(
          selectedItemColor: Style.primaryColor,
          currentIndex: barIndex,
          onTap: (index) {
            setState(() {
              barIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: 'All Voters'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Result')
          ]);
    } else if (bodywidget == 'My profile') {
      var bottom = BottomNavigationBar(
          selectedItemColor: Style.primaryColor,
          currentIndex: barIndex,
          onTap: (index) {
            setState(() {
              barIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin_outlined), label: 'profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.mode_edit_outlined), label: 'Update Profile')
          ]);
      if (User.type == "Candidate") {
        bottom.items.add(BottomNavigationBarItem(
            icon: Icon(Icons.edit_attributes_outlined), label: 'Edit Program'));
      }

      return bottom;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: (lang == "En" ? TextDirection.ltr : TextDirection.rtl),
        child: Scaffold(
          appBar: appBarWidget(setLanguage,
              title: (lang == "En" ? bodywidget : dictionary[bodywidget])),
          drawer: AppDrawer(changeBody),
          backgroundColor: Style.backgroundColor,
          body: bodyWidget(),
          bottomNavigationBar: bottomBar(),
        ));
  }
}
