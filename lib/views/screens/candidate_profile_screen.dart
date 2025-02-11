import 'package:cyv/models/candidates.dart';
import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/widgets/profiles/program_widget.dart';
import 'package:cyv/views/widgets/social_widget.dart';
import 'package:flutter/material.dart';
import 'package:cyv/views/widgets/app_bar_widget.dart';

class CandidateProfileScreen extends StatefulWidget {
  static const routeName = 'candidate Profile';
  CandidateProfileScreenState createState() => CandidateProfileScreenState();
}

class CandidateProfileScreenState extends State<CandidateProfileScreen> {
  void setLanguage() {
    setState(() {
      lang = lang == "En" ? "ع" : "En";
      direction = lang == "En" ? TextDirection.ltr : TextDirection.rtl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // get candidate index
    final indexes = ModalRoute.of(context).settings.arguments as List<dynamic>;
    final String trackID = indexes[0] as String;
    final String candidateID = indexes[1] as String;

    Candidate candidate =
        CandidatesModel.tracks[trackID].candidates[candidateID];

    final double height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: (lang == "En" ? TextDirection.ltr : TextDirection.rtl),
      child: Scaffold(
        appBar: appBarWidget(setLanguage, title: candidate.name),
        backgroundColor: Style.primaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Stack(children: <Widget>[
            // background container
            Container(
              height: height,
              color: Style.lightColor,
            ),
            // candidate image
            Container(
              width: double.infinity,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                color: Style.primaryColor,
                // image: DecorationImage(
                //     image: NetworkImage(candidate.img), fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            // program and the list of candidates if group track
            Container(
                color: Style.lightColor,
                margin: const EdgeInsets.only(top: 300),
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                child: ProgramWidget(candidate.program)),
            // name of candidate and his social accounts
            Positioned(
              top: 70,
              right: 20,
              left: 20,
              child: Container(
                height: 230,
                // margin: EdgeInsets.symmetric(vertical: 150, horizontal: 15),
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Style.lightColor,
                    boxShadow: [
                      BoxShadow(
                        color: Style.primaryColor,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 0),
                      )
                    ],
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      width: 130,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: NetworkImage(candidate.img),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // name of the candidate
                            Text(
                              candidate.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Style.darkColor,
                              ),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            //his track
                            Text(
                              CandidatesModel.tracks[trackID].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Style.secondColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // his social accounts
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SocialWidget(
                                      img: 'facebook',
                                      url: candidate.facebookUrl),
                                  SocialWidget(
                                      img: 'twitter', url: candidate.twitterUrl)
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
