/* import 'package:cyv/models/candidates_model.dart';
import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CandidatesWidget extends StatefulWidget {
  final bool resultFlag;
  CandidatesWidget({this.resultFlag = false});
  _CandidatesWidgetState createState() => _CandidatesWidgetState();
}

class _CandidatesWidgetState extends State<CandidatesWidget> {
  bool folded = true;
  int _index = 0;
  int n = CandidatesModel.tracks.length;
  TextEditingController searchController = TextEditingController();

  void search(String value) {
    CandidatesModel.tracks[_index].candidates.forEach((candidate) {
      if (candidate.name.toLowerCase().contains(value.toLowerCase())) {
        candidate.isVisible = true;
      } else {
        candidate.isVisible = false;
      }
    });
  }

  @override
  void dispose() {
    if (!widget.resultFlag) {
      search('');
      searchController.text = '';
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !widget.resultFlag
            ? AnimatedContainer(
                margin: EdgeInsets.only(left: 18),
                duration: Duration(milliseconds: 400),
                width: folded ? 56 : 350,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                    boxShadow: kElevationToShadow[6]),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(folded ? 32 : 0),
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(folded ? 32 : 0),
                              bottomRight: Radius.circular(32)),
                          onTap: () {
                            setState(() {
                              folded = !folded;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(
                              folded ? Icons.search : Icons.close,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.only(left: 16),
                            child: !folded
                                ? TextField(
                                    controller: searchController,
                                    decoration: InputDecoration(
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      setState(() {
                                        search(value);
                                      });
                                    },
                                  )
                                : null)),
                  ],
                ),
              )
            // ? Container(
            //     width: double.infinity,
            //     margin: EdgeInsets.symmetric(horizontal: 30),
            //     height: 80,
            //     child: TextField(
            //       controller: searchController,
            //       style: TextStyle(
            //         color: Style.primaryColor,
            //       ),
            //       cursorColor: Color.fromRGBO(160, 140, 238, 1),
            //       decoration: InputDecoration(
            //         icon: Icon(
            //           Icons.search,
            //           color: Style.primaryColor,
            //         ),
            //         labelText: 'search',
            //       ),
            //       onChanged: (value) {
            //         setState(() {
            //           search(value);
            //         });
            //       },
            //     ),
            //   )
            : Container(),
        Expanded(
          child: PageView(
              onPageChanged: (val) {
                setState(() {
                  search('');
                  searchController.text = '';
                  _index = val;
                });
              },
              children: tracks()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dots(),
        )
      ],
    );
  }

  List<Widget> tracks() {
    List<Widget> ch = [];
    for (var i = 0; i < n; i++) {
      //ch.add(TrackWidget(i, widget.resultFlag, widget.getProfile));
    }
    return ch;
  }

  List<Widget> dots() {
    List<Widget> ch = [];
    for (var i = 0; i < n; i++) {
      ch.add(Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: i == _index ? Style.primaryColor : Colors.grey,
            shape: BoxShape.circle,
          )));
    }
    return ch;
  }
}
 */