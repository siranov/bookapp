import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

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
