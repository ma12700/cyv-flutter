import 'package:cyv/models/candidates_model.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/screens/candidate_profile_screen.dart';
import 'package:flutter/material.dart';

class CandidateCardWidget extends StatelessWidget {
  final String trackID;
  final int candidateIndex;
  final Function vote;
  CandidateCardWidget(this.trackID, this.candidateIndex, {this.vote});
  @override
  Widget build(BuildContext context) {
    Size deviseSize = MediaQuery.of(context).size;
    Candidate candidate =
        CandidatesModel.tracks[trackID].candidates[candidateIndex];
    final bool flag = CandidatesModel.tracks[trackID].votes.length <
        CandidatesModel.tracks[trackID].numberOfWinners;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CandidateProfileScreen.routeName,
            arguments: [trackID, candidateIndex]);
      },
      child: Card(
        elevation: 16.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Style.nullColor, width: 4),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(15),
        child: Container(
          //height: 340,
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Container(
                      color: Style.primaryColor,
                      height: 130,
                    ),
                  ),
                  Container(
                      child: Container(
                    color: Style.lightColor,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 75, bottom: 20),
                            child: Text(
                              candidate.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Style.darkColor),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            )),
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
                                  ? (candidate.isSelected
                                      ? 'Un-Select'
                                      : 'Select')
                                  : (candidate.isSelected
                                      ? dictionary['Un-Select']
                                      : dictionary['Select']),
                              style: TextStyle(
                                  color: Style.lightColor, fontSize: 15),
                            ),
                          ),
                        )
                        //ResultInfoWidget(Style.primaryColor, 70, 120, 1000)
                      ],
                    ),
                  )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 45,
                  right: lang == "En" ? 0 : ((deviseSize.width - 50) / 2) - 75,
                  left: lang == "En" ? ((deviseSize.width - 50) / 2) - 75 : 0,
                ),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Style.secondColor),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(candidate.img),
                          fit: BoxFit.fill)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
