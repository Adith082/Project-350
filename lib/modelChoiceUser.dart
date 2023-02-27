import 'package:fake_image_detector/workFlowUser2.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'workFlowUser.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class ModelChoiceUser extends StatefulWidget {
  /// const ModelChoiceUser({Key key}) : super(key: key);
  User user;
  ModelChoiceUser({this.user});
  @override
  State<ModelChoiceUser> createState() => _ModelChoiceUserState();
}

class _ModelChoiceUserState extends State<ModelChoiceUser> {
  Future signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FakeImageDetectorFrontPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'Deep Fake Detector',
          style: TextStyle(color: Colors.red[100]),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Colors.orange,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            /* decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.green,
                  blurRadius: 10.0,
                  spreadRadius: 10, //New
                ),
              ],
            ),*/
            child: Text("Choose a detector",
                style: TextStyle(fontSize: 35, color: Colors.black)),
            margin: const EdgeInsets.fromLTRB(45, 0, 0, 0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
          SizedBox(height: 70),
          Container(
            //   margin: const EdgeInsets.fromLTRB(40.0, 0, 0, 0),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.blue,
                  blurRadius: 25.0,
                  spreadRadius: 10, //New
                )
              ],
            ),
            margin: const EdgeInsets.fromLTRB(80.0, 0, 30, 0),
            // padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkFlowUser(
                      user: widget.user,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue[600],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50)),
              child: Container(
                child: Text(
                  'Detector 1',
                  style: TextStyle(color: Colors.red[50], fontSize: 35),
                ),
              ),
            ),
          ),
          SizedBox(height: 70),
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.red,
                  blurRadius: 25.0,
                  spreadRadius: 10, //New
                )
              ],
            ),
            margin: const EdgeInsets.fromLTRB(80, 0, 30, 0),
            // padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkFlowUser2(
                      user: widget.user,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent[900],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50)),
              child: Container(
                child: Text(
                  'Detector 2',
                  style: TextStyle(color: Colors.red[50], fontSize: 35),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
