import 'package:cyv/models/candidates_model.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/views/widgets/app_bar_widget.dart';
import 'package:cyv/views/widgets/candidates/candidate_card_widget.dart';
import 'package:cyv/views/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class CandidatesScreen extends StatefulWidget {
  static const routeName = 'candidate screen';
  _CandidatesScreenState createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen> {
  int trackIndex;
  // used when search about candidates
  void changeVisibility(String value) {
    CandidatesModel.tracks[trackIndex].candidates.forEach((candidate) {
      if (candidate.name.toLowerCase().contains(value.toLowerCase())) {
        candidate.isVisible = true;
      } else {
        candidate.isVisible = false;
      }
    });
  }

  void setLanguage() {
    setState(() {
      lang = lang == "En" ? "ع" : "En";
      direction = lang == "En" ? TextDirection.ltr : TextDirection.rtl;
    });
  }

  void search(String value) {
    setState(() {
      changeVisibility(value);
    });
  }

  @override
  void dispose() {
    // return all unvisible candidate to normal state before leave page
    changeVisibility('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    trackIndex = ModalRoute.of(context).settings.arguments;

    return Directionality(
        textDirection: (lang == "En" ? TextDirection.ltr : TextDirection.rtl),
        child: Scaffold(
          appBar: appBarWidget(setLanguage,
              title: CandidatesModel.tracks[trackIndex].name),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  // search widget
                  Container(
                      margin: EdgeInsets.all(10),
                      child: SearchWidget(search: search)),
                  //     // list of candidates
                  Column(
                    children: CandidatesModel.tracks[trackIndex].candidates
                        .map((e) => Container(
                              child: e.isVisible
                                  ? CandidateCardWidget(
                                      trackIndex,
                                      CandidatesModel
                                          .tracks[trackIndex].candidates
                                          .indexOf(e))
                                  : Container(),
                            ))
                        .toList(),
                  ),
                ],
              )),
        ));
  }
}