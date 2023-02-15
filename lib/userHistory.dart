import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'workFlowUser.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class UserHistory extends StatefulWidget {
  // const UserHistory({Key key}) : super(key: key);
  User user;
  UserHistory({this.user});
  @override
  State<UserHistory> createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  Future signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FakeImageDetectorFrontPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
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
      body: Text(widget.user.uid),
    );
  }
}
