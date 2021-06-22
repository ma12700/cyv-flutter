import 'package:cyv/models/language.dart';
import 'package:cyv/models/style.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final Function search;

  const SearchWidget({Key key, this.search}) : super(key: key);
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: 350,
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Style.lightColor,
          boxShadow: kElevationToShadow[6]),
      child: Row(
        children: [
          Container(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.search('');
                    searchController.text = '';
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(
                    Icons.search,
                    color: Style.secondColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 16),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText:
                            (lang == 'En' ? "Search" : dictionary["Search"]),
                        hintStyle: TextStyle(
                          color: Style.nullColor,
                        ),
                        border: InputBorder.none),
                    onChanged: (value) {
                      setState(() {
                        widget.search(value);
                      });
                    },
                  ))),
        ],
      ),
    );
  }
}
