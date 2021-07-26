import 'dart:async';

class Attribute {
  final String key;
  final bool update;
  final List<String> values;
  String answer = "";

  Attribute(this.key, this.update, this.values, this.answer);
}

enum Time { before, candidature, noThing, waiving, voting, result }

class Periods {
  static DateTime candidatureStart;
  static DateTime candidatureEnd;
  static DateTime waiverStart;
  static DateTime waiverEnd;
  static DateTime votingStart;
  static DateTime votingEnd;
  static DateTime serverDate;
  static Time time = Time.before;
  static Timer timer;

  static void calculateTime(Function change) {
    print(serverDate);
    print(time);
    if (candidatureStart != null && timer == null) {
      print("Function calculateTime");
      if (serverDate.isBefore(candidatureStart)) {
        time = Time.before;
        changeTime(serverDate, candidatureStart, change);
      } else if (serverDate.isBefore(candidatureEnd)) {
        time = Time.candidature;
        changeTime(serverDate, candidatureEnd, change);
      } else if (serverDate.isBefore(waiverStart)) {
        time = Time.noThing;
        changeTime(serverDate, waiverStart, change);
      } else if (serverDate.isBefore(waiverEnd)) {
        time = Time.waiving;
        changeTime(serverDate, waiverEnd, change);
      } else if (serverDate.isBefore(votingStart)) {
        time = Time.noThing;
        changeTime(serverDate, votingStart, change);
      } else if (serverDate.isBefore(votingEnd)) {
        time = Time.voting;
        changeTime(serverDate, votingEnd, change);
      } else if (serverDate.isAfter(votingEnd)) {
        time = Time.result;
      }
    }
  }

  static void changeTime(DateTime now, DateTime end, Function change) {
    timer = Timer(Duration(minutes: end.difference(now).inMinutes), () {
      serverDate = serverDate = end.add(Duration(seconds: 10));
      if (timer != null) {
        timer.cancel();
        timer = null;
      }
      change('Home');
    });
  }

  static void clearTime() {
    candidatureStart = null;
    candidatureEnd = null;
    waiverStart = null;
    waiverEnd = null;
    votingStart = null;
    votingEnd = null;
    serverDate = null;
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
    time = Time.before;
  }
}

class User {
  static String id;
  static String type;
  static String name;
  static String img;
  static String nid;
  static String email;
  static bool state;
  static String password;
  static bool isCandidature;
  static String etherumAddress;
  static String token;
  static String program = "";
  static String facebookURL = "";
  static String twitterURL = "";
  static String trackID = "";
  static String page = "Home";
  static Map<String, dynamic> otherAttributes = {};
  static List<Attribute> attributesValues = [];

  static void storeUserData(Map<String, dynamic> data) {
    type = data["user"]['type'];
    isCandidature = data["user"]['isCandidature'];
    state = data["user"]['state'];
    id = data["user"]['_id'];
    img = data["user"]['image'];
    name = data["user"]['name'];
    nid = data["user"]['nationalID'];
    etherumAddress = data["user"]['etherumAddress'];
    (data["user"]['statistics'] as List<dynamic>).forEach((attribute) {
      var attr = attribute as Map<String, dynamic>;
      otherAttributes[attr['key']] = attr['value'];
    });
    if (data['electionPeriods'] != null) {
      Periods.candidatureStart =
          DateTime.parse(data['electionPeriods']['candidatureStart']);
      Periods.candidatureEnd =
          DateTime.parse(data['electionPeriods']['candidatureEnd']);
      Periods.waiverStart =
          DateTime.parse(data['electionPeriods']['waiverStart']);
      Periods.waiverEnd = DateTime.parse(data['electionPeriods']['waiverEnd']);
      Periods.votingStart =
          DateTime.parse(data['electionPeriods']['votingStart']);
      Periods.votingEnd = DateTime.parse(data['electionPeriods']['votingEnd']);
      Periods.serverDate =
          DateTime.parse(data['serverDate']).add(Duration(hours: 2));
    }
  }

  static void storeProgramData(Map<String, dynamic> data) {
    program = data['program'];
    facebookURL = data['facebookURL'];
    twitterURL = data['twitterURL'];
    trackID = data['trackID'];
  }

  static void updateData(Map<String, dynamic> data) {
    type = data['type'];
    isCandidature = data['isCandidature'];
    state = data['state'];
    id = data['_id'];
    img = data['image'];
    name = data['name'];
    nid = data['nationalID'];
    etherumAddress = data['etherumAddress'];
    attributesValues = [];
    (data['statistics'] as List<dynamic>).forEach((attribute) {
      var attr = attribute as Map<String, dynamic>;
      var values =
          (attr['values'] as List<dynamic>).map((e) => e.toString()).toList();
      otherAttributes[attr['key']] = attr['value'];

      try {
        attributesValues
            .add(Attribute(attr['key'], attr['update'], values, attr['value']));
      } catch (e) {
        print('here : ' + e);
      }
    });
  }
}
