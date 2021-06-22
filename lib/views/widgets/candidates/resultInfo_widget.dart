import 'package:flutter/material.dart';

class ResultInfoWidget extends StatelessWidget {
  final Color cardColor;
  final double percent;
  final int votesNumber;
  final int totalVoters;
  ResultInfoWidget(
      this.cardColor, this.percent, this.votesNumber, this.totalVoters);
  @override
  Widget build(BuildContext context) {
    Size deviseSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(children: [
          Container(
            width: deviseSize.width - 70,
            height: 10,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: cardColor),
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          Container(
            width: (percent * (deviseSize.width - 70)) / 100.0,
            height: 10,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: cardColor),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: cardColor),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            percent.toStringAsFixed(1) +
                "%   (" +
                votesNumber.toString() +
                "/" +
                totalVoters.toString() +
                ")",
            style: TextStyle(
                color: cardColor, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
