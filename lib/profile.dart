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
              Container(
                height: 150,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text('Guest', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : AuthPage();
  }
}
