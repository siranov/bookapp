import 'package:bookapp/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Book App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home:
            // TestWidget(),
            HomePage(
          update: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  VoidCallback sets() {
    setState(() {});
  }
}
