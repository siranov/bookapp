import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String email = '';
  String phone = '';
  String name = '';
  auth(context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: phone)
          .then((value) {
        user = value.user;
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  lineCheck() {}
  buttonCheck() {
    bool everythingTrue = true;
    if (email != '') {
      everythingTrue = false;
    }
    if (phone != '') {
      everythingTrue = false;
    }
    if (name != '') {
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
              },
            ),
            SmartField(
              hint: 'Phone Number',
              icon: Icons.phone,
              val: (val) {
                phone = val;
              },
              type: TextInputType.phone,
            ),
            SmartField(
              hint: 'Email',
              val: (val) {
                email = val;
              },
              icon: Icons.email,
            ),
            Divider(),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
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
