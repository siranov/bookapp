import 'package:bookapp/auth.dart';
import 'package:bookapp/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

ScrollController profC = new ScrollController();

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<DocumentSnapshot> myBooks = [];

  fetchMyBooks() async {
    await FirebaseFirestore.instance
        .collection('Books')
        .where('sellerId', isEqualTo: user.email)
        .limit(5)
        .get()
        .then((qs) {
      myBooks.addAll(qs.docs);
    });
    setState(() {});
  }

  @override
  void initState() {
    fetchMyBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userCheck()
        ? ListView(
            controller: profC,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: [
                    Container(
                      // child: Icon(
                      //   Icons.person,
                      //   size: 40,
                      // ),

                      child: Center(
                          child: Text(
                        "🤩",
                        style: TextStyle(fontSize: 115),
                      )),
                      height: 150,
                      width: 170,
                    ),
                    Positioned(
                      left: 125,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return dialog();
                            },
                          );
                        },
                        child: Container(
                            child: Icon(Icons.edit),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black12)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 7,
              ),
              Column(
                children: [
                  Text(
                    "Name: ",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                  Container(
                    height: 7,
                  ),
                  Text(
                    "User Name",
                  ),
                  Container(
                    height: 15,
                  ),
                  Text(
                    "Email: ",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                  Container(
                    height: 7,
                  ),
                  Text("User Email"),
                  Container(
                    height: 15,
                  ),
                  Text(
                    "Phone Number: ",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                  Container(
                    height: 7,
                  ),
                  Text("209 999-9999")
                ],
              ),
              Container(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('My Listings:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Column(
                children: List.generate(myBooks.length, (index) {
                  return BookWidget(
                    doc: myBooks[index],
                    index: index,
                    isMine: true,
                  );
                }),
              ),
            ],
          )
        : AuthPage();
  }

  Widget dialog() {
    return Center(
      child: Container(
        color: Colors.orange.shade300,
        height: 150,
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("🤩", style: TextStyle(fontSize: 80)),
              height: 100,
              width: 100,
            ),
            Container(
              child: Text("😜", style: TextStyle(fontSize: 80)),
              height: 100,
              width: 100,
            ),
            Container(
              child: Text("🥱", style: TextStyle(fontSize: 80)),
              height: 100,
              width: 100,
            )
          ],
        ),
      ),
    );
  }
}
