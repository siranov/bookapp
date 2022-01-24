import 'dart:async';
import 'package:algolia/algolia.dart';
import 'package:bookapp/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextEditingController searchC = new TextEditingController();
StreamController<String> onSubmit = StreamController<String>.broadcast();
ScrollController searchScroll = new ScrollController();
Timer searchTimer;

List<DocumentSnapshot> results = [];
List<DocumentSnapshot> searchD = [];
List tempoRes = [];

int lastSearchPosition = 0;

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

  List<Map> searchResults = [];

  String prevSearch = '';
  bool noResults = false;

  bool resultsLoading = false;
  bool docsLoading = false;

  bool fetchingMore = false;

  listen() {
    if (prevSearch != searchC.text) {
      resultsLoading = true;
      setState(() {});
      var request = searchC.text;
      if (request.length != 0) {
        if (searchTimer != null) {
          searchTimer.cancel();
        }
        searchTimer = new Timer(Duration(seconds: 1), () {
          searchFirestore(request);
        });
      } else {
        if (searchTimer != null) searchTimer.cancel();
        resultsLoading = false;
        searchResults.clear();
      }
    }
    prevSearch = searchC.text;
  }

  searchFirestore(request) async {
    try {
      searchResults.clear();
      AlgoliaQuery query = algolia.instance.index('book').query(request);
      AlgoliaQuerySnapshot snap = await query.getObjects();
      print('Completed Algolia Search');
      snap.hits.forEach((element) {
        var res = element.highlightResult;
        var displayResult;
        var type;
        res.keys.forEach((elem) {
          if (res[elem]['matchLevel'] != 'none') {
            displayResult = element.data[elem];
            type = elem;
          }
        });
        if (type != 'path') {
          searchResults.add({
            'docID': element.objectID,
            'result': displayResult,
            'type': type
          });
        }
      });
      noResults = searchResults.length == 0;
      resultsLoading = false;
      setState(() {});
    } catch (err) {
      print(err);
    }
  }

  submit(val) async {
    print('User submitted the field');
    if (val == 'Pressed Submit') {
      if (searchResults.length != 0) {
        fetchFirestore();
      }
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      searchD.clear();
      setState(() {});
    }
  }

  fetchFirestore() async {
    FocusManager.instance.primaryFocus?.unfocus();
    docsLoading = true;
    List<Future> docs = [];
    tempoRes = [];
    tempoRes.addAll(searchResults);
    var fetchRange = tempoRes
        .getRange(
            lastSearchPosition,
            lastSearchPosition + 5 > tempoRes.length
                ? tempoRes.length
                : lastSearchPosition + 5)
        .toList();
    print('Fetching ${fetchRange.length} documents');
    fetchRange.forEach((element) {
      docs.add(FirebaseFirestore.instance
          .collection('Books')
          .doc(element['docID'])
          .get()
          .then((DocumentSnapshot ds) => searchD.add(ds)));
    });
    searchD.clear();
    setState(() {});
    await Future.wait(docs);
    if (tempoRes.length > 1) {
      var replaceInd =
          searchD.indexWhere((doc) => doc.id == tempoRes[0]['docID']);
      var val = searchD[replaceInd];
      searchD.removeAt(replaceInd);
      searchD.insert(0, val);
    }
    searchResults.clear();
    docsLoading = false;
    lastSearchPosition = lastSearchPosition + 5 > tempoRes.length
        ? tempoRes.length
        : lastSearchPosition + 5;
    setState(() {});
  }

  fetchMore() async {
    if (searchScroll.position.maxScrollExtent - searchScroll.position.pixels <
            300 &&
        !fetchingMore) {
      if (lastSearchPosition != tempoRes.length) {
        fetchingMore = true;
        print(
            'Fetching more search documents... (From $lastSearchPosition to ${lastSearchPosition + 5 > tempoRes.length ? tempoRes.length : lastSearchPosition + 5})');
        List<Future> docs = [];
        var fetchRange = tempoRes
            .getRange(
                lastSearchPosition,
                lastSearchPosition + 5 > tempoRes.length
                    ? tempoRes.length
                    : lastSearchPosition + 5)
            .toList();
        print('Fetching ${fetchRange.length} documents');
        fetchRange.forEach((element) {
          docs.add(FirebaseFirestore.instance
              .collection('Books')
              .doc(element['docID'])
              .get()
              .then((DocumentSnapshot ds) => searchD.add(ds)));
        });
        await Future.wait(docs);
        lastSearchPosition = lastSearchPosition + 5 > tempoRes.length
            ? tempoRes.length
            : lastSearchPosition + 5;
        setState(() {});
        fetchingMore = false;
      }
    }
  }

  @override
  void initState() {
    onSubmit = StreamController<String>.broadcast();
    searchC.addListener(listen);
    onSubmit.stream.listen((val) {
      submit(val);
    });
    searchScroll.addListener(fetchMore);
    super.initState();
  }

  @override
  void dispose() {
    searchC.removeListener(listen);
    onSubmit.close();
    searchScroll.removeListener(fetchMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: !docsLoading
              ? ListView.builder(
                  controller: searchScroll,
                  physics: BouncingScrollPhysics(),
                  itemCount: searchD.length,
                  itemBuilder: (context, index) {
                    return BookWidget(
                      index: index,
                      doc: searchD[index],
                    );
                  },
                )
              : Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: resultsLoading
                ? 50.0
                : (searchResults.length == 0
                    ? (noResults ? 50.0 : 0)
                    : (searchResults.length > 6
                        ? 300.0
                        : searchResults.length * 50.0)),
            child: !resultsLoading
                ? (!noResults
                    ? ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              var res = searchResults[index];
                              searchResults.removeAt(index);
                              searchResults.insert(0, res);
                              lastSearchPosition = 0;
                              print(searchResults);
                              fetchFirestore();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                  )
                                ],
                              ),
                              height: 50,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(searchResults[index]['result']),
                                    Icon(Icons.forward)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            )
                          ],
                        ),
                        height: 50,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Center(
                            child: Text('No results found.'),
                          ),
                        ),
                      ))
                : Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Loading results...'),
                        Container(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.deepOrange,
                              strokeWidth: 1,
                            )),
                      ],
                    )),
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
                onChanged: (val) {
                  if (val.length == 0 || val.length == 1) {
                    setState(() {});
                  }
                },
                onSubmitted: (val) {
                  onSubmit.add('Pressed Submit');
                },
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
            GestureDetector(
              onTap: () {
                if (searchC.text.length != 0) {
                  searchC.clear();
                } else {
                  onSubmit.add('Pressed Close');
                }
              },
              child: Container(
                  color: Colors.transparent, child: Icon(Icons.close)),
            )
          ],
        ),
      ),
    );
  }
}
