class Help {
  String img;
  String question;
  String ans;
  Help(this.question, this.img, this.ans);
}

class HelpModel {
  static List<Help> helpContents = [
    Help("what is this App For ? ", "assets/images/help2.png",
        "this application aims to make it easy for you to cast your vote in safe manner without any fraud and without forcing the user to vote for specific candidate.  "),
    Help(
      "what is Features ? ",
      "assets/images/help1.png",
      "Enabling the candidate to easily know the required instructions and apply for candidacy through the form, as the voter can see the electoral program for all candidates ",
    ),
    Help("How to use ? ", "assets/images/help3.png",
        "this application aims to make it easy for you to cast your vote in safe manner without any fraud and without forcing the user to vote for specific candidate.  ")
  ];
}
