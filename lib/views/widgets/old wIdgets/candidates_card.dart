/*class CandidateCard extends StatelessWidget {
  final int trackIndex;
  final int candidateIndex;
  final bool voteFlag;
  final bool resultFlag;
  final Function vote;
  final Function getProfile;
  CandidateCard(this.trackIndex, this.candidateIndex, this.voteFlag,
      this.resultFlag, this.vote,
      {this.getProfile});

  @override
  Widget build(BuildContext context) {
    Candidate candidate =
        CandidatesModel.tracks[trackIndex].candidates[candidateIndex];
    Size deviseSize = MediaQuery.of(context).size;
    double percent =
        (candidate.votesNumber / CandidatesModel.totalVoters) * 100.0;
    final Color cardColor = (candidate.isSelected && voteFlag) ||
            (candidateIndex <
                    CandidatesModel.tracks[trackIndex].numberOfWinners &&
                resultFlag)
        ? Color.fromRGBO(255, 88, 119, 1)
        : (voteFlag &&
                    CandidatesModel.tracks[trackIndex].selected.length <
                        CandidatesModel.tracks[trackIndex].numberOfWinners) ||
                (!voteFlag && !resultFlag)
            ? Style.primaryColor
            : Color.fromRGBO(112, 112, 112, 1);
    return InkWell(
      onTap: (!voteFlag && !resultFlag)
          ? () {
              getProfile('candidateProfile',
                  flagArrow: true,
                  trackIndex: trackIndex,
                  candidateIndex: candidateIndex);
            }
          : () {},
      child: Card(
        elevation: 16.0,
        margin: EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 4, color: Colors.grey),
              borderRadius: BorderRadius.circular(12)),
          height: voteFlag
              ? 320
              : resultFlag
                  ? 400
                  : 340,
          width: voteFlag ? 300 : double.infinity,
          child: Stack(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Container(
                      color: cardColor,
                      height: 160,
                    ),
                  ),
                  Container(
                      child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 90, bottom: 3),
                            child: Text(
                              candidate.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                              softWrap: true,
                              //overflow: TextOverflow.ellipsis,
                            )),
                        voteFlag
                            ? Container(
                                width: 150,
                                padding: EdgeInsets.all(10),
                                child: RaisedButton(
                                  color: cardColor,
                                  onPressed: CandidatesModel.tracks[trackIndex]
                                                  .selected.length <
                                              CandidatesModel.tracks[trackIndex]
                                                  .numberOfWinners ||
                                          candidate.isSelected
                                      ? () {
                                          vote(candidate);
                                        }
                                      : null,
                                  child: Text(
                                    candidate.isSelected ? 'Voted' : 'Vote',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : resultFlag
                                ? ResultInfoWidget(
                                    cardColor,
                                    percent,
                                    candidate.votesNumber,
                                    CandidatesModel.totalVoters)
                                : Container(),
                      ],
                    ),
                  )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 75,
                  left: voteFlag ? 75 : ((deviseSize.width - 50) / 2) - 75,
                ),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4, color: Color.fromRGBO(255, 88, 119, 1)),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(candidate.img), fit: BoxFit.fill)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}*/
