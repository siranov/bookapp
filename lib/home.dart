import 'package:bookapp/bookProfile.dart';
import 'package:bookapp/profile.dart';
import 'package:bookapp/search.dart';
import 'package:bookapp/sellbook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'mybooks.dart';

int curPage = 0;
User user;

userCheck() {
  var loggedIn = true;
  if (user == null) {
    loggedIn = false;
  } else {
    if (user.isAnonymous) {
      loggedIn = false;
    }
  }
  return loggedIn;
}

GlobalKey<ScaffoldState> scaff = new GlobalKey<ScaffoldState>();

class HomePage extends StatefulWidget {
  final VoidCallback update;

  const HomePage({Key key, this.update}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  initUser() async {
    user = await FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    initUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaff,
      appBar: AppBar(
        title: Text('Book App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: curPage == 0
                  ? ListWidget()
                  : curPage == 1
                      ? Search()
                      : curPage == 2
                          ? (userCheck()
                              ? SellBook(
                                  update: () {
                                    setState(() {});
                                  },
                                )
                              : AuthPage(
                                  update: () {
                                    setState(() {});
                                  },
                                ))
                          : ProfilePage(),
            ),
          ),
          NavigBar(
            update: () {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

class NavigBar extends StatelessWidget {
  final VoidCallback update;

  const NavigBar({Key key, this.update}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      color: Colors.black12,
      child: Row(
        children: [
          icoName(Icons.home, 'Home', 0),
          icoName(Icons.search, 'Search', 1),
          icoName(Icons.attach_money_rounded, 'Sell', 2),
          icoName(Icons.person, 'Profile', 3),
        ],
      ),
    );
  }

  Widget icoName(icon, text, i) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          curPage = i;
          update();
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: curPage == i ? Colors.deepOrange : Colors.black,
              ),
              Text(text,
                  style: TextStyle(
                      fontSize: 10,
                      color: curPage == i ? Colors.deepOrange : Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}

List<DocumentSnapshot> books = [];

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  ScrollController scroll = new ScrollController();

  bool loadedFirst = false;

  bool loadingNew = false;
  bool gotAllBooks = false;

  @override
  void initState() {
    scroll.addListener(() {
      scrollListener();
    });
    loadFirstBooks();
    super.initState();
  }

  scrollListener() {
    if (scroll.position.maxScrollExtent - scroll.position.pixels < 250 &&
        !loadingNew &&
        !gotAllBooks) {
      loadMoreBooks();
    }
  }

  loadMoreBooks() async {
    print('adding more books...');
    loadingNew = true;
    await FirebaseFirestore.instance
        .collection('Books')
        .limit(5)
        .startAfterDocument(books.last)
        .get()
        .then((q) {
      books.addAll(q.docs);
      if (q.docs.length < 5) {
        gotAllBooks = true;
        print('Got all books from the list');
      }
    });
    print('added more books, current length is ${books.length}');
    loadingNew = false;
    setState(() {});
  }

  loadFirstBooks() async {
    if (books.length == 0) {
      var docs =
          await FirebaseFirestore.instance.collection('Books').limit(5).get();
      books.addAll(docs.docs);
      loadedFirst = true;
      setState(() {});
    } else {
      loadedFirst = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        child: loadedFirst
            ? ListView.builder(
                controller: scroll,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final data = books[index].data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullBookPage(
                                  doc: books[index],
                                )),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: index == 0 ? 20 : 0,
                          bottom: 20),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(blurRadius: 3, color: Colors.black38)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Text(data['bookname'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                      height: 30,
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 90.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons
                                                .perm_data_setting_outlined),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                data['course'],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                      height: 120,
                                    ),
                                    Text(
                                      '            ' +
                                          data['price']
                                              .toStringAsFixed(2)
                                              .replaceAllMapped(
                                                  RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => "${m[1]},") +
                                          ' \$',
                                      style: TextStyle(fontSize: 25),
                                      textAlign: TextAlign.end,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                height: 250,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4)),
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(data['pic'])),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : ListView.builder(
                itemCount: 3,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: index == 0 ? 20 : 0,
                        bottom: 20),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(blurRadius: 3, color: Colors.black38)
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                    5,
                                    (i) => Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            height: 20,
                                            color: Colors.black12,
                                          ),
                                        ))),
                          ),
                          Expanded(
                            child: Center(
                              child: Icon(Icons.image),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
  }
}

class DrawerWid extends StatefulWidget {
  final VoidCallback update;

  const DrawerWid({Key key, this.update}) : super(key: key);
  @override
  _DrawerWidState createState() => _DrawerWidState();
}

class _DrawerWidState extends State<DrawerWid> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(height: 80),
          Container(
            height: 150,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('Guest', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
          section('Main Page', Icons.home, 0, () {
            widget.update();
          }),
          section('Sell', Icons.book, 1, () {
            widget.update();
          }),
          section('My listings', Icons.attach_money, 2, () {
            widget.update();
          }),
        ],
      ),
    );
  }

  Widget section(name, icon, i, callback) {
    return GestureDetector(
      onTap: () {
        curPage = i;
        callback();
      },
      child: Container(
        color: curPage == i ? Colors.deepOrange : Colors.transparent,
        height: 60,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(name,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: curPage == i ? Colors.white : Colors.black)),
              ),
              Icon(
                icon,
                size: 20,
                color: curPage == i ? Colors.white : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
