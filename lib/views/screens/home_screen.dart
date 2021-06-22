import 'package:cyv/models/candidates_model.dart';
import 'package:cyv/models/infoPages_model.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/widgets/app_bar_widget.dart';
import 'package:cyv/views/widgets/tracks_widget.dart';
import '../widgets/help_widget.dart';
import '../widgets/vote_widget.dart';
import 'package:cyv/views/widgets/drawer_widget.dart';
import 'package:cyv/views/widgets/info_pages_widget.dart';
import 'package:cyv/views/widgets/waive_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/my_profile_widget.dart';
import 'package:cyv/views/widgets/candidatureForm.dart';
import '../widgets/statistics.dart';
import '../../models/series_data.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String bodywidget = 'Home';
  void changeBody(String value) {
    if (bodywidget != value) {
      setState(() {
        bodywidget = value;
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
        InfoPageModel.pages.clear();
        return InfoPageModel.pages.isNotEmpty
            ? PagesWidget()
            : future(InfoPageModel.fetchPages, PagesWidget());
      case 'Candidates':
        return CandidatesModel.tracks.isNotEmpty
            ? TracksWidget()
            : future(CandidatesModel.fetchTracks, TracksWidget());
      case 'Cnadidature':
        return CandidatesModel.tracks.isNotEmpty
            ? TracksWidget(
                isCandidature: true,
              )
            : future(
                CandidatesModel.fetchTracks,
                TracksWidget(
                  isCandidature: true,
                ));
      case 'CnadidatureForm':
        return FormData();
      case 'Waiving':
        return WaiveWidget();
      case 'Voting':
        return VoteWidget();
      case 'Result':
        return TracksWidget(); //CandidatesWidget(resultFlag: true);
      case 'statistics':
        return Subscribechart(ChartData.data);
      case 'My profile':
        return MyProfileWidget();
      case 'Help':
        return HelpWidget();
      default:
        return Center();
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
      ),
    );
  }
}
