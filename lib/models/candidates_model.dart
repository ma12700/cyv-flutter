import 'dart:convert';
import 'package:cyv/models/user_model.dart';
import 'package:http/http.dart' as http;

class Candidate {
  final String id;
  final String name;
  final String img;
  final int votesNumber;
  String facebookUrl = 'https://www.facebook.com';
  String twitterUrl = 'https://www.twitter.com';
  String program =
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.';
  bool isVisible = true;
  bool isSelected = false;
  Candidate(this.id, this.name, this.img, this.votesNumber);
}

class Track {
  final String id;
  final String name;
  final String dividedBy;
  final int numberOfCandidates;
  final int numberOfWinners;
  List<Candidate> candidates = [];
  List<String> selected = [];
  Track(this.id, this.name, this.dividedBy, this.numberOfCandidates,
      this.numberOfWinners);
}

class CandidatesModel {
  // candidates at each track
  static bool isResultAppear = false;
  static int totalVoters = 75;
  static List<Track> tracks = [];
  static Future<bool> fetchTracks() async {
    try {
      tracks.clear();
      var url = Uri.parse('https://e-votingfci.herokuapp.com/track/getTrack');
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
      var data = json.decode(response.body);
      data.forEach((track) {
        tracks.add(Track(track['_id'], track['title'], track['dividedBy'],
            (track['NofCandidates'] as int), (track['NofWinners'] as int)));
      });
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return true;
  }

  static Future<bool> fetchCandidates() async {
    try {
      tracks.clear();
      var url = Uri.parse('https://e-votingfci.herokuapp.com/candidate/getCandidate');
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': User.token
      });
      var data = json.decode(response.body);
      data.forEach((track) {
        tracks.add(Track(track['_id'], track['title'], track['dividedBy'],
            (track['NofCandidates'] as int), (track['NofWinners'] as int)));
      });
    } catch (e) {
      print('error: ');
      print(e.toString());
    }
    return true;
  }
}
