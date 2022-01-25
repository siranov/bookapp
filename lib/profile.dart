import 'package:bookapp/auth.dart';
import 'package:bookapp/home.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return userCheck()
        ? Column(
            children: [
              // Container(
              //   height: 150,
              //   child: Row(children: [
              //     Column(
              //       children: [
              //         Padding(
              //           padding: EdgeInsets.only(top: 20, bottom: 20),
              //           child: Container(
              //             height: 40,
              //             width: 40,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //             ),
              //             child: Center(
              //               child: Icon(Icons.person),
              //             ),
              //           ),
              //         ),
              //         Expanded(
              //           child: Center(
              //             child: Text('Guest', style: TextStyle(fontSize: 16)),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ]),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Row(
              //children: [

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
