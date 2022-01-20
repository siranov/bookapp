import 'dart:ui';

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
      body: ListView(
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
                        image: NetworkImage(data['pic']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
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
                      image: NetworkImage(data['pic']), fit: BoxFit.fitHeight),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 30,
              ),
              Text(
                data['bookname'],
                style: TextStyle(fontSize: 25),
              ),
              Text(data['course'], style: TextStyle(fontSize: 25)),
              Text(data["profname"], style: TextStyle(fontSize: 25)),
              Text(data['condition'], style: TextStyle(fontSize: 25)),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  data['price'].toStringAsFixed(2).replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => "${m[1]},") +
                      ' \$',
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                height: 50,
              ),
              Row(children: [
                Container(
                    child: Icon(
                      Icons.person,
                      size: 40,
                    ),
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepOrange)),
                Expanded(
                  child: Column(
                    children: [Text('Name:'), Text('Phone:'), Text('Email:')],
                  ),
                )
              ])
            ]),
          ),
        ],
      ),
    );
  }
}
