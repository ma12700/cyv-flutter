import 'package:cyv/models/candidates.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';

class VoteCandidateCard extends StatelessWidget {
  final String trackID;
  final int candidateIndex;
  final Function vote;
  VoteCandidateCard(this.trackID, this.candidateIndex, this.vote);

  @override
  Widget build(BuildContext context) {
    Candidate candidate =
        CandidatesModel.tracks[trackID].candidates[candidateIndex];
    final bool flag = CandidatesModel.tracks[trackID].votes.length <
        CandidatesModel.tracks[trackID].numberOfWinners;
    final Color cardColor = (candidate.isSelected)
        ? Style.primaryColor
        : flag
            ? Style.primaryColor
            : Style.nullColor;
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(15),
      child: Container(
        child: Stack(children: [
          Container(
            height: double.infinity,
            width: 130,
            color: cardColor,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: cardColor,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(candidate.img),
                          fit: BoxFit.fill)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 250,
                    child: Text(
                      candidate.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Style.darkColor),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: candidate.isSelected
                              ? Style.buttonColor(Style.secondColor)
                              : flag
                                  ? Style.buttonColor(Style.primaryColor)
                                  : Style.buttonColor(Style.nullColor)),
                      onPressed: flag || candidate.isSelected
                          ? () {
                              vote(candidate);
                            }
                          : null,
                      child: Text(
                        lang == 'En'
                            ? (candidate.isSelected ? 'Un-Select' : 'Select')
                            : (candidate.isSelected
                                ? dictionary['Un-Select']
                                : dictionary['Select']),
                        style: TextStyle(color: Style.lightColor, fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
