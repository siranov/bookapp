import 'dart:async';
import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextEditingController searchC = new TextEditingController();
Timer searchTimer;

List<DocumentSnapshot> results = [];

class AlgoliaApp {
  static final Algolia algolia = Algolia.init(
    applicationId: 'T9XQHLJ3MS',
    apiKey: '111596de449dafab9175956361a8f21a',
  );
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Algolia algolia = AlgoliaApp.algolia;

  listen() {
    var request = searchC.text;
    if (request.length != 0) {
      if (searchTimer != null) {
        searchTimer.cancel();
      }
      searchTimer = new Timer(Duration(milliseconds: 500), () {
        searchFirestore(request);
      });
    } else {
      if (searchTimer != null) searchTimer.cancel();
    }
  }

  searchFirestore(request) async {
    AlgoliaQuery query = algolia.instance.index('contacts').query(request);
    AlgoliaQuerySnapshot snap = await query.getObjects();
    print('Hits count: ${snap.nbHits}');
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
