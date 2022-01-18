import 'package:bookapp/home.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

String condition;
double price = 0;
String sellerName;
String course;
String profName;
String bookName;
dynamic imageFile;

class SellBook extends StatefulWidget {
  final update;

  const SellBook({Key key, this.update}) : super(key: key);
  @override
  _SellBookState createState() => _SellBookState();
}

class _SellBookState extends State<SellBook> {
  bool picked = false;

  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      picked = true;
      setState(() {});
      Navigator.of(context).pop();
    }
  }

  /// Get from camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = await File(pickedFile.path);
      print(imageFile.path);
      picked = true;
      print('im here');
      setState(() {});
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWid(
        update: widget.update,
      ),
      appBar: AppBar(
        title: Text('Sell Book'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: TextFormField(
                onChanged: (value) {
                  bookName = value;
                },
                cursorColor: Theme.of(context).cursorColor,
                initialValue: 'Insert Name',
                maxLength: 20,
                decoration: InputDecoration(
                  icon: Icon(Icons.favorite),
                  labelText: 'Book Name',
                  labelStyle: TextStyle(
                    color: Color(0xFF6200EE),
                  ),
                  helperText: 'Helper text',
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: TextFormField(
              onChanged: (value) {
                profName = value;
              },
              cursorColor: Theme.of(context).cursorColor,
              initialValue: 'Insert Name',
              maxLength: 20,
              decoration: InputDecoration(
                icon: Icon(Icons.favorite),
                labelText: 'Professor Name',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
                helperText: 'Helper text',
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: TextFormField(
              onChanged: (value) {
                course = value;
              },
              cursorColor: Theme.of(context).cursorColor,
              initialValue: 'Insert Course',
              maxLength: 20,
              decoration: InputDecoration(
                icon: Icon(Icons.favorite),
                labelText: 'Course Related to Book',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
                helperText: 'Helper text',
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: TextFormField(
              onChanged: (value) {
                sellerName = value;
              },
              cursorColor: Theme.of(context).cursorColor,
              initialValue: 'Insert Name',
              maxLength: 20,
              decoration: InputDecoration(
                icon: Icon(Icons.favorite),
                labelText: 'Seller Name',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
                helperText: 'Helper text',
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: TextFormField(
              onChanged: (value) {
                price = double.parse(value);
              },
              cursorColor: Theme.of(context).cursorColor,
              initialValue: 'Insert Price',
              maxLength: 20,
              decoration: InputDecoration(
                icon: Icon(Icons.favorite),
                labelText: 'Book Price',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
                helperText: 'Helper text',
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: TextFormField(
              onChanged: (value) {
                condition = value;
              },
              cursorColor: Theme.of(context).cursorColor,
              initialValue: 'Insert Condition',
              maxLength: 20,
              decoration: InputDecoration(
                icon: Icon(Icons.favorite),
                labelText: 'Book Condition',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
                helperText: 'Helper text',
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
          ),
          Divider(),
          Container(
              child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctxt) {
                          return DialogWid(
                            camera: () {
                              _getFromCamera();
                            },
                            gallery: () {
                              _getFromGallery();
                            },
                          );
                        });
                  },
                  child: Center(
                    child: Text(
                      " Add Book Picture",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          )),
          picked
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.5),
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (checkFields() == true) {
                      print('worked');

                      var bookData = {
                        'bookname': bookName, //put your bookname variable here
                        'sellerId': sellerName, //this ill get after auth
                        'course': course, //put your course variable here
                        'price': price, //put your price variable here
                        'picFile': imageFile, //put your file variable here
                        'condition':
                            condition, //put your condition variable here
                      };
                    } else {
                      print('fields are empty');
                    }
                  },
                  child: Center(
                    child: Text(
                      " Upload Book",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DialogWid extends StatelessWidget {
  final camera;
  final gallery;

  const DialogWid({Key key, this.camera, this.gallery}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Image from :'),
      shape: RoundedRectangleBorder(),
      actions: [
        RaisedButton(
          onPressed: () {
            camera();
          },
          color: Colors.white,
          child: Text('Camera'),
        ),
        RaisedButton(
          onPressed: () {
            gallery();
          },
          color: Colors.white,
          child: Text('Gallery'),
        ),
      ],
    );
  }
}

checkFields() {
  bool everythingIsCorrect = true;
  if (bookName == '') {
    everythingIsCorrect = false;
  }
  if (profName == '') {
    everythingIsCorrect = false;
  }
  if (course == '') {
    everythingIsCorrect = false;
  }
  if (sellerName == '') {
    everythingIsCorrect = false;
  }
  if (price < 0) {
    everythingIsCorrect = false;
  }
  if (condition == '') {
    everythingIsCorrect = false;
  }
  if (imageFile == null) {
    everythingIsCorrect = false;
  }
  return everythingIsCorrect;
}
