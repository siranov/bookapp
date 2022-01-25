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
                child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepOrange)),
              ),
              Container(
                height: 25,
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
}
