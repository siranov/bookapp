import 'dart:ui';

import 'package:bookapp/profWid.dart';
import 'package:bookapp/sellbook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FullBookPage extends StatefulWidget {
  final DocumentSnapshot doc;

  const FullBookPage({Key key, this.doc}) : super(key: key);
  @override
  _FullBookPageState createState() => _FullBookPageState();
}

class _FullBookPageState extends State<FullBookPage> {
  DocumentSnapshot d;
  var data;

  @override
  void initState() {
    d = widget.doc;
    data = d.data() as Map<String, dynamic>;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: [
            Container(
              height: 200,
              width: double.maxFinite,
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    child: Container(
                      width: 350,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            data['pic'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    child: Image(
                      image: NetworkImage(data['pic']),
                      fit: BoxFit.fitHeight,
                      loadingBuilder: (context, child, loadingProgress) {
                        return loadingProgress == null
                            ? child
                            : LinearProgressIndicator(
                                color: Colors.black26,
                                backgroundColor: Colors.black12,
                                value: loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes,
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 25),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black12),
                        height: 40,
                        width: 40,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                    ),
                    Text("Book's Name: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange)),
                    Text(
                      data['bookname'],
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: 10,
                    ),
                    Text(
                      "Author's Name: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                    Text(data['authorName'], style: TextStyle(fontSize: 20)),
                    Container(
                      height: 10,
                    ),
                    Text(
                      "Course's Name: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                    Text(data['course'], style: TextStyle(fontSize: 20)),
                    Container(
                      height: 10,
                    ),
                    Text(
                      "Professor's Name: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                    Text(data["profname"], style: TextStyle(fontSize: 20)),
                    Container(
                      height: 10,
                    ),
                    Text(
                      "Book Condition: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                    Text(data['condition'], style: TextStyle(fontSize: 20)),
                    Container(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        data['price'].toStringAsFixed(2).replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => "${m[1]},") +
                            ' \$',
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Container(
                      height: 40,
                    ),
                    ProfileWid(
                      book: widget.doc,
                    ),
                    Container(height: 40),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
