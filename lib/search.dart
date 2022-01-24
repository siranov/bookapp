import 'dart:async';
import 'package:algolia/algolia.dart';
import 'package:bookapp/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextEditingController searchC = new TextEditingController();
StreamController<String> onSubmit = StreamController<String>.broadcast();
Timer searchTimer;

List<DocumentSnapshot> results = [];
List<DocumentSnapshot> searchD = [];

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
      noResults = snap.hits.length == 0;
      snap.hits.forEach((element) {
        var res = element.highlightResult;
        var displayResult;
        res.keys.forEach((elem) {
          if (res[elem]['matchLevel'] != 'none') {
            displayResult = element.data[elem];
          }
        });
        searchResults.add({'docID': element.objectID, 'result': displayResult});
      });
      resultsLoading = false;
      setState(() {});
      print(searchResults);
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
    searchResults.forEach((element) {
      docs.add(FirebaseFirestore.instance
          .collection('Books')
          .doc(element['docID'])
          .get()
          .then((DocumentSnapshot ds) => searchD.add(ds)));
    });
    searchD.clear();
    setState(() {});
    await Future.wait(docs);
    searchResults.clear();
    docsLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    onSubmit = StreamController<String>.broadcast();
    searchC.addListener(listen);
    onSubmit.stream.listen((val) {
      submit(val);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchC.removeListener(listen);
    onSubmit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: !docsLoading
              ? ListView.builder(
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
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            constraints: BoxConstraints(maxHeight: 300),
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
