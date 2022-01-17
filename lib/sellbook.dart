import 'package:bookapp/home.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

String condition;
int price;
String sellerName;
String course;
String profName;
String bookName;

class SellBook extends StatefulWidget {
  final update;

  const SellBook({Key key, this.update}) : super(key: key);
  @override
  _SellBookState createState() => _SellBookState();
}

class _SellBookState extends State<SellBook> {
  dynamic imageFile;
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
                  price = int.parse(value);
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
                child: picked == false
                    ? Padding(
                        padding: const EdgeInsets.only(left: 40.0),
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
                                child: Text(
                                  " Add Book Picture",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: 100,
                        child: Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                        ),
                      ))
          ],
        ),
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

var bookData = {
  'bookname': 'Book book book', //put your bookname variable here
  'sellerId': 'siranov', //this ill get after auth
  'course': 'Phys 53', //put your course variable here
  'price': 26, //put your price variable here
  'picFile': '', //put your file variable here
  'condition': 'Good', //put your condition variable here
};
