import 'dart:io';

import 'package:bookapp/home.dart';
import 'package:bookapp/sellbook.dart';
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

addBook(dataPayload, context) async {
  await FirebaseFirestore.instance.collection('Books').add(dataPayload);
  print('uploaded to firestore');
  Navigator.of(context).pop();
  controller1.clear();
  controller2.clear();
  controller3.clear();
  controller4.clear();
  controller5.clear();
  controller6.clear();
}

uploadBookImage(File file, load, context) async {
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
      'sellerId': user.email,
      'course': load['course'],
      'price': load['price'],
      'pic': url,
      'condition': load['condition'],
      'profname': load['profname'],
      'authorName': load['authorName'],
    }, context);
  } catch (err) {
    print(err);
  }
}

uploadNewBook(bookPayload, context) {
  uploadBookImage(bookPayload['picFile'], bookPayload, context);
}
