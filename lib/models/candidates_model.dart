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
  Track(this.name, this.dividedBy, this.numberOfWinners);
}

class CandidatesModel {
  // candidates at each track
  static bool isResultAppear = false;
  static int totalVoters = 75;
  static Map<String, Track> tracks = {};

  static Future<bool> fetchTracks() async {
    try {
      tracks.clear();
      var url = Uri.parse(User.url + 'track/getTrack');
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
      var data = json.decode(response.body);
      data.forEach((track) {
        tracks[track['_id']] = Track(
            track['title'], track['dividedBy'], (track['NofWinners'] as int));
      });
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return true;
  }

  static Future<bool> fetchCandidates(String trackID) async {
    try {
      tracks.clear();
      var url = Uri.parse(User.url +
          'candidate/getCandidate/?trackID=' +
          trackID +
          'dividedBy=' +
          User.otherAttributes[trackID]);
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
      var data = json.decode(response.body);
      tracks[trackID].candidates = [];
      data.forEach((candidate) {
        tracks[trackID].candidates.add(Candidate(
            candidate['_id'],
            candidate['name'],
            candidate['image'],
            0,
            candidate['facebookURL'],
            candidate['twitterUrl'],
            candidate['program']));
      });
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return true;
  }

  static Future<bool> waive() async {
    bool flag = false;
    try {
      var url = Uri.parse(User.url + 'candidate/waive');
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
      var url = Uri.parse(User.url + 'candidate/vote');
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
