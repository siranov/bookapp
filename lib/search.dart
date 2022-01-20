import 'package:flutter/material.dart';

TextEditingController searchC = new TextEditingController();

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  listen() {
    print(searchC.text);
  }

  @override
  void initState() {
    searchC.addListener(listen);
    listen();
    super.initState();
  }

  @override
  void dispose() {
    searchC.removeListener(listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                controller: searchC,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search books...',
                  hintStyle: TextStyle(color: Colors.white54),
                ),
              ),
            ),
            Icon(Icons.close)
          ],
        ),
      ),
    );
  }
}
