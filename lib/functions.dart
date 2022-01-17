import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  void initState() {
    getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              addBook();
            },
            child: Container(
              color: Colors.purple,
              height: 50,
              width: 100,
              child: Center(
                child: Text("Upload", style: TextStyle(color: Colors.white)),
              ),
            )),
      ),
    );
  }
}

getBooks() async {
  List<DocumentSnapshot> books = [];
  print('this function starts');
  var ref = await FirebaseFirestore.instance
      .collection('Books')
      .get()
      .then((query) => books.addAll(query.docs));
  books.forEach((DocumentSnapshot element) {
    print(element.data());
  });
}

addBook() async {
  await FirebaseFirestore.instance.collection('Books').add({
    'bookname': 'Book book book',
    'sellerId': 'siranov',
    'course': 'Phys 53',
    'price': 26,
    'pic':
        'https://static.scientificamerican.com/sciam/cache/file/1DDFE633-2B85-468D-B28D05ADAE7D1AD8_source.jpg?w=590&h=800&D80F3D79-4382-49FA-BE4B4D0C62A5C3ED',
    'condition': 'Good',
  });
}

var bookData = {
  'bookname': 'Book book book', //put your bookname variable here
  'sellerId': 'siranov', //this ill get after auth
  'course': 'Phys 53', //put your course variable here
  'price': 26, //put your price variable here
  'picFile': '', //put your file variable here
  'condition': 'Good', //put your condition variable here
};
