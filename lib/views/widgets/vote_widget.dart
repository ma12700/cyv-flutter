import 'package:cyv/controllers/candidate.dart';
import 'package:cyv/models/candidates.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';
import 'package:cyv/views/widgets/button_widget.dart';
import 'package:cyv/views/widgets/candidates/candidate_card_widget.dart';
import 'package:cyv/views/widgets/candidates/title_card.dart';
import 'package:cyv/views/widgets/dialog.dart';
import 'package:flutter/material.dart';

class VoteWidget extends StatefulWidget {
  _VoteWidgetState createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {
  var trackKeys;
  var candidatesKeys;
  int _trackIndex = 0;
  bool isSend = false;
  int n = CandidatesModel.tracks.length;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    trackKeys = CandidatesModel.tracks.keys.toList();
    candidatesKeys =
        CandidatesModel.tracks[trackKeys[_trackIndex]].candidates.keys.toList();
    //final size = MediaQuery.of(context).size;
    return Column(
      children: [
        TitleCard(CandidatesModel.tracks[trackKeys[_trackIndex]].name),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              itemCount: CandidatesModel
                  .tracks[trackKeys[_trackIndex]].candidates.length,
              itemBuilder: (context, index) {
                return CandidateCardWidget(
                    trackKeys[_trackIndex], candidatesKeys[index],
                    vote: vote);
              }),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            (lang == 'En' ? 'You must choose (' : dictionary["YMC"]) +
                CandidatesModel.tracks[trackKeys[_trackIndex]].numberOfWinners
                    .toString() +
                (lang == 'En' ? ") candidate(s)." : dictionary["CO"]),
            style: TextStyle(
                color: Style.darkColor,
                shadows: [
                  BoxShadow(
                    color: Style.primaryColor,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  )
                ],
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _trackIndex > 0
                  ? ButtonWidget(
                      text: (lang == 'En' ? 'Back' : dictionary['Back']),
                      navigate: () {
                        setState(() {
                          changeTrack(false);
                          scrollController.jumpTo(0);
                        });
                      },
                    )
                  : Container(),
              isSend
                  ? CircularProgressIndicator()
                  : ButtonWidget(
                      text: _trackIndex == n - 1
                          ? (lang == 'En' ? 'Cast Vote' : dictionary['CV'])
                          : (lang == 'En' ? 'Next' : dictionary['Next']),
                      navigate: CandidatesModel.tracks[trackKeys[_trackIndex]]
                                  .votes.length ==
                              CandidatesModel.tracks[trackKeys[_trackIndex]]
                                  .numberOfWinners
                          ? () async {
                              if (_trackIndex != n - 1) {
                                setState(() {
                                  changeTrack(true);
                                  scrollController.jumpTo(0);
                                });
                              } else {
                                setState(() {
                                  isSend = !isSend;
                                });
                                bool result = await CandidatesCtr.vote();
                                if (result) {
                                  User.state = true;
                                  showErrorDialog(
                                      lang == "En"
                                          ? "send successfuly"
                                          : "تم الارسال",
                                      context,
                                      title: "Succeed",
                                      backToHome: true);
                                } else {
                                  showErrorDialog(
                                      lang == "En"
                                          ? "An Error Occured"
                                          : "هناك خطأ",
                                      context);
                                }
                                setState(() {
                                  isSend = !isSend;
                                });
                              }
                            }
                          : null,
                    )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            (_trackIndex + 1).toString() + ' / ' + n.toString(),
            style: TextStyle(
                color: Style.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  void vote(Candidate candidate, String candidateID) {
    setState(() {
      candidate.isSelected = !candidate.isSelected;
      if (candidate.isSelected) {
        CandidatesModel.tracks[trackKeys[_trackIndex]].votes.add(candidateID);
      } else {
        CandidatesModel.tracks[trackKeys[_trackIndex]].votes
            .removeWhere((element) => element == candidateID);
      }
    });
  }

  void changeTrack(bool inc) {
    setState(() {
      inc ? _trackIndex++ : _trackIndex--;
    });
  }
}
