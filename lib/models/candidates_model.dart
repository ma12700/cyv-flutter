import 'dart:convert';
import 'package:cyv/models/user_model.dart';
import 'package:http/http.dart' as http;

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
  // candidates at each track
  static bool isResultAppear = false;
  static int totalVoters = 75;
  static Map<String, Track> tracks = {};

  static Future<bool> fetchTracks() async {
    tracks.clear();
    var url = Uri.parse(User.baseUrl + 'track/getTrack');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    var data = json.decode(response.body);
    data.forEach((track) {
      tracks[track['_id']] = Track(
          track['title'], track['dividedBy'], (track['NofWinners'] as int), []);
    });

    return true;
  }

  static Future<bool> fetchAll() async {
    tracks.clear();
    var url = Uri.parse(User.baseUrl + 'candidate/getCandidate');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    var data = json.decode(response.body);
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

    return true;
  }

  static Future<bool> fetchCandidates(String trackID) async {
    try {
      var url = Uri.parse(User.baseUrl +
          'candidate/getCandidate/?trackID=' +
          trackID +
          '&dividedBy=' +
          User.otherAttributes[tracks[trackID].dividedBy]);

      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
      var data = json.decode(response.body);
      tracks[trackID].candidates = [];
      (data as List<dynamic>).forEach((cand) {
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
    } catch (e) {
      print('error ' + e);
    }
    return true;
  }

  static Future<bool> waive() async {
    bool flag = false;
    try {
      var url = Uri.parse(User.baseUrl + 'candidate/waive');
      await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return flag;
  }

  static Future<bool> vote() async {
    bool flag = false;
    try {
      var url = Uri.parse(User.baseUrl + 'candidate/vote');
      await http.post(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      }, body: {
        "result": tracks.entries
            .map((track) =>
                {"track": track.key, "candidateID": track.value.votes})
            .toList()
      });
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return flag;
  }
}
