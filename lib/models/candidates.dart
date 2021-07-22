import 'dart:collection';

class Candidate {
  String name;
  String img;
  int votesNumber;
  String facebookUrl;
  String twitterUrl;
  String program;
  bool isVisible = true;
  bool isSelected = false;
  Candidate(this.name, this.img, this.votesNumber, this.facebookUrl,
      this.twitterUrl, this.program);
}

class Track {
  final String name;
  final String dividedBy;
  final int numberOfWinners;
  Map<String, Candidate> candidates = {};
  List<String> votes = [];
  Track(this.name, this.dividedBy, this.numberOfWinners, this.candidates);
}

class CandidatesModel {
  static Map<String, Track> tracks = {};

  static void storeTracks(List<dynamic> data) {
    tracks.clear();
    data.forEach((track) {
      tracks[track['_id']] = Track(
          track['title'], track['dividedBy'], (track['NofWinners'] as int), {});
    });
  }

  static void storeCandidates(String trackID, List<dynamic> data) {
    tracks[trackID].candidates.clear();
    data.forEach((cand) {
      var candidate = cand as Map<String, dynamic>;
      tracks[trackID].candidates[candidate['_id']['_id']] = Candidate(
          candidate['_id']['name'],
          candidate['_id']['image'],
          0,
          candidate['facebookURL'],
          candidate['twitterURL'],
          candidate['program']);
    });
  }

  static void storeAll(List<dynamic> data) {
    tracks.clear();
    data.forEach((track) {
      tracks[track['track']['_id']] = Track(
          track['track']['title'],
          track['track']['dividedBy'],
          (track['track']['NofWinners'] as int), {});
      tracks[track['track']['_id']].candidates = {};

      (track['candidates'] as List<dynamic>).forEach((cand) {
        var candidate = cand as Map<String, dynamic>;
        tracks[track['track']['_id']].candidates[candidate['_id']['_id']] =
            Candidate(
                candidate['_id']['name'],
                candidate['_id']['image'],
                0,
                candidate['facebookURL'],
                candidate['twitterURL'],
                candidate['program']);
      });
    });
  }

  static void storeResult(List<dynamic> result, String trackID) {
    try {
      List ids = result[0];
      List votesCount = result[1];
      int len = ids.length;
      for (int i = 0; i < len; i++) {
        tracks[trackID].candidates[ids[i]].votesNumber =
            int.parse(votesCount[i]);
      }
      var sort = SplayTreeMap.from(
          tracks[trackID].candidates,
          (a, b) => tracks[trackID].candidates[a].votesNumber <
                  tracks[trackID].candidates[b].votesNumber
              ? 1
              : -1);
      tracks[trackID].candidates.clear();
      sort.forEach((key, value) {
        tracks[trackID].candidates[key] = value;
      });
    } catch (e) {}
  }
}
