import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullBookPage extends StatefulWidget {
  @override
  _FullBookPageState createState() => _FullBookPageState();
}

class _FullBookPageState extends State<FullBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            child: Stack(
              children: [
                Container(
                    height: 200,
                    width: double.maxFinite,
                    child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://api.time.com/wp-content/uploads/2015/06/521811839-copy.jpg?quality=85&w=507&h=338&crop=1'))),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black12),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 30,
              ),
              Text(
                'Book Name :',
                style: TextStyle(fontSize: 25),
              ),
              Text('Book Course : ', style: TextStyle(fontSize: 25)),
              Text("Professor's Name: ", style: TextStyle(fontSize: 25)),
              Text('Condition:', style: TextStyle(fontSize: 25)),
              Text(
                'Price: \$',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.end,
              ),
              Container(
                height: 50,
              ),
              Row(children: [
                Container(
                    child: Icon(
                      Icons.person,
                      size: 40,
                    ),
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepOrange)),
                Expanded(
                  child: Column(
                    children: [Text('Name:'), Text('Phone:'), Text('Email:')],
                  ),
                )
              ])
            ]),
          ),
        ],
      ),
    );
  }
}
