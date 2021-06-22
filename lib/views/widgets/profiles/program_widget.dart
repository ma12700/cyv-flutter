import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cyv/models/candidates_model.dart';

class ProgramWidget extends StatelessWidget {
  final String program;
  ProgramWidget(this.program);
  @override
  Widget build(BuildContext context) {
    int _trackIndex = 0;
    // int n = CandidatesModel.tracks.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Group's Members
        Text(
          (lang == 'En' ? "Group's Members" : dictionary['GM']),
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

        Container(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: CandidatesModel.tracks[_trackIndex].candidates.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
                    decoration: BoxDecoration(
                        color: Style.lightColor,
                        border: Border.all(
                          width: 2,
                          color: Style.darkColor,
                        )),
                    width: 200.0,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Image.asset(
                              "assets/images/ali.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Center(
                              child: Text(CandidatesModel
                                  .tracks[_trackIndex].candidates[index].name)),
                        ),
                      ],
                    ));
              }),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          (lang == 'En' ? "The Election Program" : dictionary['TEP']),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Style.darkColor,
          ),
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            color: Colors.white,
            margin: EdgeInsets.all(5),
            child: program.isEmpty
                ? Column(
                    children: [
                      Text(
                        (lang == 'En'
                            ? "No Election Program added Yet !"
                            : dictionary['NEPA']),
                        style: TextStyle(
                            shadows: [
                              BoxShadow(
                                color: Style.primaryColor,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 0),
                              )
                            ],
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Image.asset(
                        "assets/images/noProgram.png",
                        height: 150,
                      ),
                    ],
                  )
                : Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          )
                        ],
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Text(
                      program,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )),
      ],
    );
  }
}
