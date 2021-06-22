import 'dart:math';

import 'package:cyv/models/candidates_model.dart';
import 'package:cyv/views/screens/candidates_screen.dart';
import 'package:cyv/views/widgets/fform.dart';
import 'package:flutter/material.dart';

class TracksWidget extends StatelessWidget {
  final _random = Random();
  final bool isCandidature;

  TracksWidget({this.isCandidature = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: CandidatesModel.tracks.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            //childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemBuilder: (_, index) {
          final Track track = CandidatesModel.tracks[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                  isCandidature ? Forms.routeName : CandidatesScreen.routeName,
                  arguments: index);
            },
            child: Card(
              elevation: 6,
              color: Color.fromRGBO(_random.nextInt(200), _random.nextInt(200),
                  _random.nextInt(200), 0.4),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  track.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
