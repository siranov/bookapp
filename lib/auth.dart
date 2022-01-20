import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AuthPage extends StatefulWidget {
  final VoidCallback update;

  const AuthPage({Key key, this.update}) : super(key: key);
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String email = '';
  String phone = '';
  String name = '';
  auth(context) async {
    if (buttonCheck()) {
      showDialog(
          context: context,
          builder: (ctx) {
            return Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email, password: phone.toString());
        user = userCredential.user;
        await FirebaseFirestore.instance.collection('Users').add({
          'email': email,
          'phone': phone,
          'name': name,
        });
        Navigator.of(context).pop();
        widget.update();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showDialog(
            context: context,
            builder: (context) =>
                Text('The phone number provided is too short.'),
          );
        } else if (e.code == 'email-already-in-use') {
          showDialog(
            context: context,
            builder: (context) =>
                Text('The account already exists for that email.'),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => Text(e.toString()),
        );
      }
    }
  }

  lineCheck(String val) {
    if (val.length == 0 || val.length == 1) {
      setState(() {});
    }
  }

  buttonCheck() {
    bool everythingTrue = true;
    if (email == '') {
      everythingTrue = false;
    }
    if (phone == '') {
      everythingTrue = false;
    }
    if (name == '') {
      everythingTrue = false;
    }
    return everythingTrue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15),
          children: [
            Text(
              "Hey! People buying your books need your contact information. Do a quick registration first.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Divider(),
            SmartField(
              hint: 'First Name',
              icon: Icons.person,
              val: (val) {
                name = val;
                lineCheck(val);
              },
            ),
            SmartField(
              hint: 'Phone Number',
              icon: Icons.phone,
              val: (val) {
                phone = val;
                lineCheck(val);
              },
              type: TextInputType.phone,
            ),
            SmartField(
              hint: 'Email',
              val: (val) {
                email = val;
                lineCheck(val);
              },
              icon: Icons.email,
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                auth(context);
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: buttonCheck() ? Colors.deepOrange : Colors.grey,
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: Text('Register',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmartField extends StatelessWidget {
  final hint;
  final icon;
  final type;
  final ValueSetter val;

  const SmartField({Key key, this.hint, this.icon, this.type, this.val})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type != null ? type : TextInputType.emailAddress,
      onChanged: (value) {
        if (val != null) {
          val(value);
        }
      },
      cursorColor: Theme.of(context).cursorColor,
      decoration: InputDecoration(
        hintText: 'Insert $hint',
        icon: Icon(icon),
        labelText: '$hint',
        labelStyle: TextStyle(
          color: Colors.deepOrange,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange),
        ),
      ),
    );
  }
}
