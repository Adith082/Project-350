import 'package:flutter/material.dart';
import "dart:io";
import "package:image_picker/image_picker.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class WorkFlow1 extends StatefulWidget {
  @override
  State<WorkFlow1> createState() => _WorkFlow1State();
}

class _WorkFlow1State extends State<WorkFlow1> {
  File _image;
  bool showSpinner = false;
  bool isVisible = false;
  bool isVisible2 = true;
  var condition = "None", confidence = "None", percent = "";
  Future UploadImage(source) async {
    var image;
    var pickedFile;
    if (source == "gallery")
      pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    else
      pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print("no image selected");
    }
    setState(() {
      showSpinner = false;
    });
    print("hello 1");
    var stream = new http.ByteStream(_image.openRead());
    stream.cast();
    var length = await _image.length();
    var uri = Uri.parse("https://stasimus-p350-fastapi.hf.space/upimg/");
    var request = new http.MultipartRequest("POST", uri);
    print("hello 2");
    print(request);
    setState(() {
      showSpinner = true;
      isVisible = false;
      isVisible2 = true;
    });

    request.files
        .add(await http.MultipartFile.fromPath("file", pickedFile.path));
    http.Response res = await http.Response.fromStream(await request.send());
    print("hello 3");
    if (res.statusCode == 200) {
      print("image uploaded");
      print("hello 5");
      final respStr = (json.decode(res.body) as Map<String, dynamic>);
      print(respStr["pred"][0][0].runtimeType);
      print(respStr["pred"].runtimeType);
      setState(() {
        if ((respStr["pred"][0][0] * 100).toStringAsFixed(2)[0] == '0') {
          condition = "Original";
          confidence = (100 - (respStr["pred"][0][0] * 100)).toStringAsFixed(2);
        } else {
          condition = "Fake";
          confidence = (respStr["pred"][0][0] * 100).toStringAsFixed(2);
        }
        percent = "%";
      });
    } else {
      print("failed");
    }
    print("hello 6");

    setState(() {
      showSpinner = false;
      isVisible = true;
      isVisible2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          backgroundColor: Colors.yellowAccent,
          appBar: AppBar(
              backgroundColor: Colors.green[900],
              title: Text("Deep Fake Detector")),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                child: Text("Picture Upload Section",
                    style: TextStyle(fontSize: 20)),
                //margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.brown)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                width: 300,
                color: Colors.lightGreenAccent,
                child: _image == null
                    ? Center(child: Text("Upload any picture to validate"))
                    : Image.file(File(_image.path).absolute),
              ),
              SizedBox(
                height: 45,
              ),
              Visibility(
                visible: isVisible2,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.brown)),
                  child: Text("Response Field",
                      style: TextStyle(
                          fontSize: 25,
                          //fontWeight: FontWeight.bold,
                          color: Colors.brown[900])),
                ),
              ),
              Visibility(
                visible: isVisible,
                child: AnimatedOpacity(
                  opacity: isVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.brown)),
                    child: Text("Condition: $condition",
                        style: TextStyle(
                            fontSize: 25,
                            // fontWeight: FontWeight.bold,
                            color: Colors.brown[900])),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isVisible,
                child: AnimatedOpacity(
                  opacity: isVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.brown)),
                    child: Text("confidence: $confidence $percent",
                        style: TextStyle(
                          fontSize: 25,
                          // fontWeight: FontWeight.bold,
                          color: Colors.brown[900],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      UploadImage("gallery");
                    },
                    backgroundColor: Colors.brown,
                    child: Icon(Icons.photo_library),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      UploadImage("camera");
                    },
                    backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.camera),
                  )
                ],
              )
            ],
          )),
    );
  }
}



















/*ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          backgroundColor: Colors.yellowAccent,
          appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text("Deep Fake Detector")),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text("Image will be shown below", style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                width: 300,
                color: Colors.lightGreenAccent,
                child: _image == null
                    ? Center(child: Text("NO PICTURE HAS BEEN SELECTED"))
                    : Image.file(File(_image.path).absolute),
              ),
              SizedBox(
                height: 45,
              ),
              Text("Condition: $condition",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text("confidence: $confidence $percent",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      UploadImage("gallery");
                    },
                    backgroundColor: Colors.brown,
                    child: Icon(Icons.photo_library),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      UploadImage("camera");
                    },
                    backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.camera),
                  )
                ],
              )
            ],
          )),
    );*/