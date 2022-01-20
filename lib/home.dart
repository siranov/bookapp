import 'package:bookapp/bookProfile.dart';
import 'package:bookapp/sellbook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

int curPage = 0;

class HomePage extends StatefulWidget {
  final VoidCallback update;

  const HomePage({Key key, this.update}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book App'),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
                padding: EdgeInsets.only(right: 12), child: Icon(Icons.search)),
          )
        ],
      ),
      drawer: DrawerWid(
        update: widget.update,
      ),
      body: ListWidget(),
    );
  }
}

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  ScrollController scroll = new ScrollController();

  List<DocumentSnapshot> books = [];

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
    var docs =
        await FirebaseFirestore.instance.collection('Books').limit(5).get();
    books.addAll(docs.docs);
    loadedFirst = true;
    setState(() {});
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
