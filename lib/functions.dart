import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {},
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

addBook(dataPayload) async {
  await FirebaseFirestore.instance.collection('Books').add(dataPayload);
  print('uploaded to firestore');
}

uploadBookImage(File file, load) async {
  var path = '/${file.path}${DateTime.now()}.png';
  print(path);
  try {
    var urlGetter;
    var url;
    await FirebaseStorage.instance
        .ref()
        .child('Books')
        .child(path)
        .putFile(file)
        .then((file) {
      urlGetter = file.ref.getDownloadURL();
    });
    url = await urlGetter;
    print('uploaded $url');
    print('uploading firestore');
    addBook({
      'bookname': load['bookname'],
      'sellerId': 'siranov',
      'course': load['course'],
      'price': load['price'],
      'pic': url,
      'condition': load['condition'],
    });
  } catch (err) {
    print(err);
  }
}

uploadNewBook(bookPayload) {
  uploadBookImage(bookPayload['picFile'], bookPayload);
}
