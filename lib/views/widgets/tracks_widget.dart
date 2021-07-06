import 'dart:math';

import 'package:cyv/models/candidates.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/views/screens/candidates_screen.dart';
import 'package:cyv/views/widgets/candidature.dart';
import 'package:flutter/material.dart';

class TracksWidget extends StatelessWidget {
  final _random = Random();
  final bool isCandidature;
  TracksWidget({this.isCandidature = false});
  @override
  Widget build(BuildContext context) {
    final keys = CandidatesModel.tracks.keys.toList();
    return CandidatesModel.tracks.length > 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: keys.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 4 / 6,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (_, index) {
                final Track track = CandidatesModel.tracks[keys[index]];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        isCandidature
                            ? CandidatureForm.routeName
                            : CandidatesScreen.routeName,
                        arguments: keys[index]);
                  },
                  child: Card(
                    elevation: 6,
                    color: Colors
                            .primaries[_random.nextInt(Colors.primaries.length)]
                        [100],
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Style.borderColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Text(
                        track.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Style.darkColor,
                          fontSize: 20,
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Text('No Tracks added yet!');
  }
}
