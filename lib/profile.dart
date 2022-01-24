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
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      Text(
                        "User Name",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                        "Email: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      Text("User Email", style: TextStyle(fontSize: 20)),
                      Container(
                        height: 10,
                      ),
                      Text(
                        "Phone Number: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      Text("209 999-9999", style: TextStyle(fontSize: 20))
                    ],
                  )
                ],
              )
            ],
          )
        : AuthPage();
  }
}
