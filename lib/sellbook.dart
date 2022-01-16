import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SellBook extends StatefulWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: TextFormField(
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
                cursorColor: Theme.of(context).cursorColor,
                initialValue: 'Insert Name',
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
                cursorColor: Theme.of(context).cursorColor,
                initialValue: 'Insert Name',
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
            Container(
                child: picked == false
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.greenAccent,
                              onPressed: () {
                                _getFromGallery();
                              },
                              child: Text("PICK FROM GALLERY"),
                            ),
                            Container(
                              height: 40.0,
                            ),
                            RaisedButton(
                              color: Colors.lightGreenAccent,
                              onPressed: () {
                                _getFromCamera();
                              },
                              child: Text("PICK FROM CAMERA"),
                            )
                          ],
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
