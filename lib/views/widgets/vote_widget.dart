import 'package:cyv/models/candidates_model.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/widgets/button_widget.dart';
import 'package:cyv/views/widgets/candidates/voteCandidate_card.dart';
import 'package:cyv/views/widgets/candidates/title_card.dart';
import 'package:flutter/material.dart';

class VoteWidget extends StatefulWidget {
  _VoteWidgetState createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {
  int _trackIndex = 0;
  int n = CandidatesModel.tracks.length;
  var keys = CandidatesModel.tracks.keys.toList();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        TitleCard(CandidatesModel.tracks[keys[_trackIndex]].name),
        Container(
          height: size.height * 0.4,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              itemCount: CandidatesModel.tracks[_trackIndex].candidates.length,
              itemBuilder: (context, index) {
                return VoteCandidateCard(keys[_trackIndex], index, vote);
              }),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            (lang == 'En' ? 'You must choose (' : dictionary["YMC"]) +
                CandidatesModel.tracks[_trackIndex].numberOfWinners.toString() +
                (lang == 'En' ? ") candidate(s) only." : dictionary["CO"]),
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
              ButtonWidget(
                text: _trackIndex == n - 1
                    ? (lang == 'En' ? 'Cast Vote' : dictionary['CV'])
                    : (lang == 'En' ? 'Next' : dictionary['Next']),
                navigate:
                    CandidatesModel.tracks[keys[_trackIndex]].votes.length ==
                            CandidatesModel
                                .tracks[keys[_trackIndex]].numberOfWinners
                        ? () {
                            if (_trackIndex != n - 1) {
                              setState(() {
                                changeTrack(true);
                                scrollController.jumpTo(0);
                              });
                            }
                          }
                        : () async {
                            bool result = await CandidatesModel.vote();
                          },
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

  void vote(Candidate candidate) {
    setState(() {
      candidate.isSelected = !candidate.isSelected;
      if (candidate.isSelected) {
        CandidatesModel.tracks[keys[_trackIndex]].votes.add(candidate.id);
      } else {
        CandidatesModel.tracks[keys[_trackIndex]].votes
            .removeWhere((element) => element == candidate.id);
      }
    });
  }

  void changeTrack(bool inc) {
    setState(() {
      inc ? _trackIndex++ : _trackIndex--;
    });
  }
}
