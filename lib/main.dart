import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "camera app",
    debugShowCheckedModeBanner: false,
    home: LoadingHomePage(),
  ));
}

class LoadingHomePage extends StatefulWidget {
  @override
  _LoadingHomePageState createState() => _LoadingHomePageState();
}

class _LoadingHomePageState extends State<LoadingHomePage> {
  File imageFile;

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice !"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _openGallery(context);
                    },
                    child: Text(
                      'Gallery',
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _openCamera(context);
                    },
                    child: Text('Camera',
                        style: TextStyle(
                            color: Colors.blueAccent, fontSize: 18.0)),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _decidedImageView() {
    if(imageFile == null){
      return Text("no Image Selected !");
    }else{
      return Image.file(imageFile , width: 400.0, height: 400.0,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera App'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("No Image Selected !"),
              _decidedImageView(),
              RaisedButton(
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text("Select Image"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
