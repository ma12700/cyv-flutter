import 'package:cyv/controllers/candidate.dart';
import 'package:cyv/controllers/infoPages.dart';
import 'package:cyv/controllers/candidature.dart';
import 'package:cyv/controllers/user.dart';
import 'package:cyv/models/candidates.dart';
import 'package:cyv/models/infoPages.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/requirements.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
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
            : future(InfoPagesCtr.fetchPages, PagesWidget());
      case 'Candidates':
        return CandidatesModel.tracks.isNotEmpty
            ? TracksWidget()
            : future(CandidatesCtr.fetchTracks, TracksWidget());
      case 'Cnadidature':
        return CandidatesModel.tracks.isNotEmpty
            ? TracksWidget(
                isCandidature: true,
              )
            : future(
                CandidatesCtr.fetchTracks, TracksWidget(isCandidature: true));
      case 'CnadidatureForm':
        return RequirementsModel.requirements.isNotEmpty
            ? CandidatureForm() //must be updated (is remining)
            : future(CandidatureCtr.fetchRequirements, CandidatureForm());
      case 'Waiving':
        return WaiveWidget(changeBody);
      case 'Voting':
        return future(CandidatesCtr.fetchAll, VoteWidget());
      case 'Result':
        return CandidatesModel.tracks.isNotEmpty
            ? TracksWidget()
            : future(CandidatesCtr.fetchTracks,
                TracksWidget()); //From Smart Contract
      case 'statistics':
        return Subscribechart(barIndex); //Waited for updating
      case 'My profile':
        return User.attributesValues.isEmpty
            ? future(UserCtr.updateData, MyProfileWidget(barIndex))
            : MyProfileWidget(barIndex);
      case 'Help':
        return HelpWidget();
      default:
        return Center();
    }
  }

  BottomNavigationBar bottomBar() {
    if (bodywidget == "statistics" && Periods.time == Time.result) {
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
                icon: Icon(Icons.people),
                label: lang == "En" ? 'All Voters' : 'جميع الناخبين'),
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: lang == "En" ? 'Result' : 'النتيجة')
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
                icon: Icon(Icons.person_pin_outlined),
                label: lang == "En" ? 'profile' : 'الملف الشخصى'),
            BottomNavigationBarItem(
                icon: Icon(Icons.mode_edit_outlined),
                label: lang == "En" ? 'Update Profile' : 'تحديث بياناتى'),
            if (User.type == "Candidate")
              BottomNavigationBarItem(
                  icon: Icon(Icons.edit_attributes_outlined),
                  label: lang == "En" ? 'Edit Program' : 'تعديل البرنامج')
          ]);

      return bottom;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Periods.calculateTime(changeBody);
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
