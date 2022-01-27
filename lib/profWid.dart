import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

DocumentSnapshot uDoc;

class ProfileWid extends StatefulWidget {
  final DocumentSnapshot book;

  const ProfileWid({Key key, this.book}) : super(key: key);
  @override
  _ProfileWidState createState() => _ProfileWidState();
}

class _ProfileWidState extends State<ProfileWid> {
  bool ready = false;

  getUserFromBook() async {
    final bookData = widget.book.data() as Map;
    final sellerId = bookData['sellerId'];
    await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: sellerId)
        .get()
        .then((qs) {
      uDoc = qs.docs.first;
      ready = true;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    getUserFromBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = ready ? uDoc.data() as Map : {};
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ready
          ? Padding(
              padding: EdgeInsets.all(10),
              child: Row(children: [
                Container(
                    child: Center(
                      child:
                          Text(data['emoji'], style: TextStyle(fontSize: 80)),
                    ),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black12)),
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      Column(
                        children: [
                          Text("Seller Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38)),
                          Text(data['name'], style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Scaffold.of(context).hideCurrentSnackBar();
                              Clipboard.setData(
                                  ClipboardData(text: data['phone']));
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Copied phone number.'),
                              ));
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Phone ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black38)),
                                  Icon(
                                    Icons.copy,
                                    size: 12,
                                    color: Colors.blue.withOpacity(0.7),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(data['phone'], style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Scaffold.of(context).hideCurrentSnackBar();
                              Clipboard.setData(
                                  ClipboardData(text: data['email']));
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Copied email.'),
                              ));
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Email ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black38)),
                                  Icon(
                                    Icons.copy,
                                    size: 12,
                                    color: Colors.blue.withOpacity(0.7),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(data['email'], style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            )
          : Container(
              height: 150,
              child: Center(
                child: LinearProgressIndicator(
                  color: Colors.grey,
                  backgroundColor: Colors.white12,
                ),
              ),
            ),
    );
  }
}
