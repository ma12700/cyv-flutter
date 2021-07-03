import 'package:cyv/models/candidates_model.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/screens/candidate_profile_screen.dart';
import 'package:cyv/views/widgets/candidates/resultInfo_widget.dart';
import 'package:flutter/material.dart';

class CandidateCardWidget extends StatelessWidget {
  final String trackID;
  final int candidateIndex;
  CandidateCardWidget(this.trackID, this.candidateIndex);
  @override
  Widget build(BuildContext context) {
    Size deviseSize = MediaQuery.of(context).size;
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
                              CandidatesModel.tracks[trackID]
                                  .candidates[candidateIndex].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Style.darkColor),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            )),
                        ResultInfoWidget(Style.primaryColor, 70, 120, 1000)
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
                          image: NetworkImage(CandidatesModel
                              .tracks[trackID].candidates[candidateIndex].img),
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
