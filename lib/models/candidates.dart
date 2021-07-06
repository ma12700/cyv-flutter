class Candidate {
  String id;
  String name;
  String img;
  int votesNumber;
  String facebookUrl;
  String twitterUrl;
  String program;
  bool isVisible = true;
  bool isSelected = false;
  Candidate(this.id, this.name, this.img, this.votesNumber, this.facebookUrl,
      this.twitterUrl, this.program);
}

class Track {
  final String name;
  final String dividedBy;
  final int numberOfWinners;
  List<Candidate> candidates = [];
  List<String> votes = [];
  Track(this.name, this.dividedBy, this.numberOfWinners, this.candidates);
}

class CandidatesModel {
  static int totalVoters = 75;
  static Map<String, Track> tracks = {};

  static void storeTracks(List<dynamic> data) {
    tracks.clear();
    data.forEach((track) {
      tracks[track['_id']] = Track(
          track['title'], track['dividedBy'], (track['NofWinners'] as int), []);
    });
  }

  static void storeCandidates(String trackID, List<dynamic> data) {
    tracks[trackID].candidates = [];
    data.forEach((cand) {
      var candidate = cand as Map<String, dynamic>;
      tracks[trackID].candidates.add(Candidate(
          candidate['_id']['_id'],
          candidate['_id']['name'],
          candidate['_id']['image'],
          0,
          candidate['facebookURL'],
          candidate['twitterURL'],
          candidate['program']));
    });
  }

  static void storeAll(List<dynamic> data) {
    tracks.clear();
    data.forEach((track) {
      tracks[track['track']['_id']] = Track(
          track['track']['title'],
          track['track']['dividedBy'],
          (track['track']['NofWinners'] as int), []);
      tracks[track['track']['_id']].candidates = [];

      (track['candidates'] as List<dynamic>).forEach((cand) {
        var candidate = cand as Map<String, dynamic>;
        tracks[track['track']['_id']].candidates.add(Candidate(
            candidate['_id']['_id'],
            candidate['_id']['name'],
            candidate['_id']['image'],
            0,
            candidate['facebookURL'],
            candidate['twitterURL'],
            candidate['program']));
      });
    });
  }
}
