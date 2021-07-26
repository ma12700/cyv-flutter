import 'dart:convert';
import 'package:cyv/controllers/auth.dart';
import 'package:cyv/controllers/contract.dart';
import 'package:cyv/controllers/user.dart';
import 'package:cyv/models/analysis.dart';
import 'package:cyv/models/candidates.dart';
import 'package:cyv/models/user.dart';
import 'package:http/http.dart' as http;

class CandidatesCtr {
  static Future<bool> fetchTracks() async {
    var url = Uri.parse(AuthCtr.baseUrl + 'track/getTrack');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    var data = json.decode(response.body);
    CandidatesModel.storeTracks(data);
    return true;
  }

  static Future<bool> fetchCandidates(String trackID) async {
    var url = Uri.parse(AuthCtr.baseUrl +
        'candidate/getCandidate/?trackID=' +
        trackID +
        '&dividedBy=' +
        User.otherAttributes[CandidatesModel.tracks[trackID].dividedBy]);

    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    var data = json.decode(response.body);
    CandidatesModel.storeCandidates(trackID, data);
    if (Periods.time == Time.result) {
      await ContractCtr.getResult(trackID,
          User.otherAttributes[CandidatesModel.tracks[trackID].dividedBy]);
    }

    return true;
  }

  static Future<bool> fetchAll() async {
    var url = Uri.parse(AuthCtr.baseUrl + 'candidate/getCandidate');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    var data = json.decode(response.body);
    CandidatesModel.storeAll(data);

    return true;
  }

  static Future<bool> waive() async {
    var url = Uri.parse(AuthCtr.baseUrl + 'candidate/waive');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': User.token
    });
    if (response.statusCode == 200) {
      await ContractCtr.submit("waive", [User.id]);
    }
    return response.statusCode == 200;
  }

  static Future<bool> vote() async {
    var url = Uri.parse(AuthCtr.baseUrl + 'candidate/vote');
    var body = {};
    body["result"] = CandidatesModel.tracks.entries
        .map((track) => {"track": track.key, "candidates": track.value.votes})
        .toList();

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': User.token
        },
        body: json.encode(body));

    if (response.statusCode == 201) {
      var tracksKeys = CandidatesModel.tracks.keys.map((e) => e).toList();
      List<String> votes = [];
      List<BigInt> noWinners = [];
      tracksKeys.forEach((key) async {
        CandidatesModel.tracks[key].votes.forEach((candidate) {
          votes.add(candidate);
        });
        noWinners.add(BigInt.from(CandidatesModel.tracks[key].numberOfWinners));
      });
      await ContractCtr.submit(
          "vote", [User.nid, tracksKeys, noWinners, votes]);
    }
    return response.statusCode == 201;
  }

  static Future<bool> updateProgram() async {
    var url = Uri.parse(AuthCtr.baseUrl + 'candidate/UpdateProfile');
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': User.token
        },
        body: json.encode({
          "program": User.program,
          "facebookURL": User.facebookURL,
          "twitterURL": User.twitterURL
        }));
    return response.statusCode == 201;
  }

  static Future<bool> fetchAnalysis() async {
    if (CandidatesModel.tracks.isEmpty) {
      await fetchTracks();
    }
    if (User.trackID == "") {
      await UserCtr.fetchProgram();
    }
    var url = Uri.parse(
        'https://floating-bastion-12576.herokuapp.com/statisticsAnalysis');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': User.token
        },
        body: json.encode({
          "dividedByKey": CandidatesModel.tracks[User.trackID].dividedBy,
          "dividedByValue": User
              .otherAttributes[CandidatesModel.tracks[User.trackID].dividedBy],
        }));
    var data = json.decode(response.body);
    ChartData.storeAllUserAnalysis(data['userStatistics']);

    return true;
  }
}
