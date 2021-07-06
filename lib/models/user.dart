class Attribute {
  final String key;
  final bool update;
  final List<String> values;
  String answer = "";

  Attribute(this.key, this.update, this.values, this.answer);
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
  static String time = "Result";
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
  }

  static void storeProgramData(Map<String, dynamic> data) {
    program = data['program'];
    facebookURL = data['facebookURL'];
    twitterURL = data['twitterURL'];
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
