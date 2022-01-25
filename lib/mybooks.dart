import 'package:bookapp/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<DocumentSnapshot> myBooks = [];

class MyBooks extends StatefulWidget {
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  fetchMyBooks() async {
    myBooks.clear();
    await FirebaseFirestore.instance
        .collection('Books')
        .where('sellerId', isEqualTo: user.email)
        .limit(5)
        .get()
        .then((qs) {
      myBooks.addAll(qs.docs);
    });
  }

  @override
  void initState() {
    fetchMyBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myBooks.length,
      itemBuilder: (context, index) {
        return BookWidget(
          doc: myBooks[index],
          index: index,
          isMine: true,
        );
      },
    );
  }
}
