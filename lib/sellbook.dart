import 'package:bookapp/functions.dart';
import 'package:bookapp/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        body: ListView(
          padding: EdgeInsets.all(15),
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: TextFormField(
                onChanged: (value) {
                  bookName = value;
                },
                cursorColor: Theme.of(context).cursorColor,
                decoration: InputDecoration(
                  hintText: 'Insert Name',
                  icon: Icon(Icons.menu_book),
                  labelText: 'Book Name',
                  labelStyle: TextStyle(
                    color: Colors.deepOrange,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
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
                decoration: InputDecoration(
                  hintText: 'Insert Name',
                  icon: Icon(Icons.person),
                  labelText: 'Professor Name',
                  labelStyle: TextStyle(
                    color: Colors.deepOrange,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
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
                decoration: InputDecoration(
                  hintText: 'Insert Course',
                  icon: Icon(Icons.perm_data_setting_outlined),
                  labelText: 'Course Related to Book',
                  labelStyle: TextStyle(
                    color: Colors.deepOrange,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.parse(value);
                },
                cursorColor: Theme.of(context).cursorColor,
                decoration: InputDecoration(
                  hintText: 'Insert Price',
                  icon: Icon(Icons.attach_money_outlined),
                  labelText: 'Book Price',
                  labelStyle: TextStyle(
                    color: Colors.deepOrange,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
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
                decoration: InputDecoration(
                  hintText: 'Insert Condition',
                  icon: Icon(Icons.warning_amber),
                  labelText: 'Book Condition',
                  labelStyle: TextStyle(
                    color: Colors.deepOrange,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                ),
              ),
            ),
            Container(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 40,
                        child: Center(
                          child: Text(
                            " Add Book Picture",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(width: 10),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 1, color: Colors.black26),
                  ),
                  child: picked
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 200,
                            width: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: 200,
                          child: Center(
                            child: Icon(Icons.image),
                          ),
                        ),
                ),
              ],
            ),
            Container(height: 30),
            GestureDetector(
                onTap: () {
                  if (checkFields() == true) {
                    print('worked');

                    var bookData = {
                      'bookname': bookName, //put your bookname variable here
                      'sellerId': sellerName, //this ill get after auth
                      'course': course, //put your course variable here
                      'price': price, //put your price variable here
                      'picFile': imageFile, //put your file variable here
                      'condition': condition, //put your condition variable here
                    };
                  } else {
                    print('fields are empty');
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      " Upload Book",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                )),
          ],
        ));
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
