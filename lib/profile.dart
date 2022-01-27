import 'package:bookapp/auth.dart';
import 'package:bookapp/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String emoji = "";
ScrollController profC = new ScrollController();
DocumentSnapshot userDoc;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<DocumentSnapshot> myBooks = [];

  bool ready = false;

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

  fetchUser() async {
    if (userDoc == null) {
      var email = user.email;
      await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email)
          .get()
          .then((qs) {
        userDoc = qs.docs.first;
      });
    }
    ready = true;
    setState(() {});
  }

  @override
  void initState() {
    fetchMyBooks();
    fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = userDoc != null ? userDoc.data() as Map : {};
    emoji = userDoc != null ? ((emoji == "") ? data['emoji'] : emoji) : emoji;
    return userCheck()
        ? ready
            ? ListView(
                controller: profC,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      children: [
                        Container(
                          child: Center(
                              child: Text(
                            emoji,
                            style: TextStyle(fontSize: 115),
                          )),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Positioned(
                          left: 225,
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
                                    shape: BoxShape.circle,
                                    color: Colors.black12)),
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
                        "Name",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      Container(
                        height: 7,
                      ),
                      Text(
                        data['name'],
                      ),
                      Container(
                        height: 15,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      Container(
                        height: 7,
                      ),
                      Text(data['email']),
                      Container(
                        height: 15,
                      ),
                      Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      Container(
                        height: 7,
                      ),
                      Text(data['phone'])
                    ],
                  ),
                  Container(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('My Listings:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
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
            : Container(
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: LinearProgressIndicator()),
                ),
              )
        : AuthPage();
  }

  updateEmoji() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userDoc.id)
        .update({
      'emoji': emoji,
    }).then((done) => Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Updated the emoji. '),
            )));
  }

  Widget dialog() {
    return Center(
      child: Container(
          height: 320,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange.shade300),
          child: Column(
            children: [
              Container(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      emoji = "🤩";
                      setState(() {});
                      Navigator.of(context).pop();
                      updateEmoji();
                    },
                    child: Container(
                      child: Text("🤩", style: TextStyle(fontSize: 80)),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      emoji = "😜";
                      setState(() {});
                      Navigator.of(context).pop();
                      updateEmoji();
                    },
                    child: Container(
                      child: Text("😜", style: TextStyle(fontSize: 80)),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      emoji = "🥱";
                      setState(() {});
                      Navigator.of(context).pop();
                      updateEmoji();
                    },
                    child: Container(
                      child: Text("🥱", style: TextStyle(fontSize: 80)),
                      height: 100,
                      width: 100,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      emoji = "🤤";
                      setState(() {});
                      Navigator.of(context).pop();
                      updateEmoji();
                    },
                    child: Container(
                      child: Text("🤤", style: TextStyle(fontSize: 80)),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      emoji = "🤑";
                      setState(() {});
                      Navigator.of(context).pop();
                      updateEmoji();
                    },
                    child: Container(
                      child: Text("🤑", style: TextStyle(fontSize: 80)),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      emoji = "🤓";
                      setState(() {});
                      Navigator.of(context).pop();
                      updateEmoji();
                    },
                    child: Container(
                      child: Text("🤓", style: TextStyle(fontSize: 80)),
                      height: 100,
                      width: 100,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      emoji = "🥴";
                      setState(() {});
                      Navigator.of(context).pop();
                      updateEmoji();
                    },
                    child: Container(
                      child: Text("🥴", style: TextStyle(fontSize: 80)),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      emoji = "😷";
                      setState(() {});
                      Navigator.of(context).pop();
                      updateEmoji();
                    },
                    child: Container(
                      child: Text("😷", style: TextStyle(fontSize: 80)),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      emoji = "😳";
                      setState(() {});
                      Navigator.of(context).pop();
                      updateEmoji();
                    },
                    child: Container(
                      child: Text("😳", style: TextStyle(fontSize: 80)),
                      height: 100,
                      width: 100,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
