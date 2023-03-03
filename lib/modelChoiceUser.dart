import 'package:fake_image_detector/workFlowUser2.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'workFlowUser.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModelChoiceUser extends StatefulWidget {
  /// const ModelChoiceUser({Key key}) : super(key: key);
  User user;

  ModelChoiceUser({this.user});
  @override
  State<ModelChoiceUser> createState() => _ModelChoiceUserState();
}

class _ModelChoiceUserState extends State<ModelChoiceUser> {
  bool likeModel1 = false;
  var _count1 = 0;
  var _count2 = 0;
  bool likeModel2 = false;
  Future initInit() async {
    // showAlert(context);
    // super.initState();
    // print(widget.user.uid);
    // AlertDialog(title: Text("Sample Alert Dialog"));
    await FirebaseFirestore.instance
        .collection("model1likecount")
        .doc("lLSCaLxWrIZnUB2B1LYL")
        .get()
        .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        _count1 = data["model1"];
      });
    });

    await FirebaseFirestore.instance
        .collection("model2likecount")
        .doc("NgnrwiZLdK6oHHzq4h1F")
        .get()
        .then((DocumentSnapshot doc) async {
      final data = await doc.data() as Map<String, dynamic>;
      setState(() {
        _count2 = data["model2"];
      });
    });
    print(
        "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhddddddddddddddddddddddddddddddddd");
    await FirebaseFirestore.instance
        .collection(widget.user.uid)
        .doc(widget.user.uid + "model1")
        .get()
        .then((value) async {
      if (value.exists) {
        await FirebaseFirestore.instance
            .collection(widget.user.uid)
            .doc(widget.user.uid + "model1")
            .get()
            .then((DocumentSnapshot doc) async {
          final data = await doc.data() as Map<String, dynamic>;
          setState(() {
            likeModel1 = data["modelbool1"];
          });
        });
      } else {
        print("WHYYYYYY ARE YOU NOT SHOWING OUT PUUUUUUUUUUUUT");
        final modelbool1 = <String, dynamic>{"modelbool1": false};
        await FirebaseFirestore.instance
            .collection(widget.user.uid)
            .doc(widget.user.uid + "model1")
            .set(modelbool1)
            .onError((e, _) => print("Error writing document: $e"));
      }
    });

    await FirebaseFirestore.instance
        .collection(widget.user.uid)
        .doc(widget.user.uid + "model2")
        .get()
        .then((value) async {
      if (value.exists) {
        await FirebaseFirestore.instance
            .collection(widget.user.uid)
            .doc(widget.user.uid + "model2")
            .get()
            .then((DocumentSnapshot doc) async {
          final data = await doc.data() as Map<String, dynamic>;
          setState(() {
            likeModel2 = data["modelbool2"];
          });
        });
      } else {
        final modelbool2 = <String, dynamic>{"modelbool2": false};
        await FirebaseFirestore.instance
            .collection(widget.user.uid)
            .doc(widget.user.uid + "model2")
            .set(modelbool2)
            .onError((e, _) => print("Error writing document: $e"));
      }
    });
  }

  void initState() {
    initInit();
  }

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
            margin: const EdgeInsets.fromLTRB(45, 0, 20, 0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
          SizedBox(height: 70),
          Container(
            margin: const EdgeInsets.fromLTRB(40.0, 0, 20, 0),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.blue,
                  blurRadius: 25.0,
                  spreadRadius: 10, //New
                )
              ],
            ),
            //     margin: const EdgeInsets.fromLTRB(80.0, 0, 30, 0),
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

          // main: MainAxisAlignment.center,
          Container(
            // padding: const EdgeInsets.all(1.0),
            margin: const EdgeInsets.fromLTRB(0, 0, 100, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    likeModel1 ? Icons.favorite : Icons.favorite_border,
                    color: likeModel1 ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      likeModel1 = !likeModel1;
                      _count1 += likeModel1 ? 1 : -1;

                      final mcount1 = <String, dynamic>{"model1": _count1};
                      final likeflag1 = <String, dynamic>{
                        "modelbool1": likeModel1
                      };
                      FirebaseFirestore.instance
                          .collection("model1likecount")
                          .doc("lLSCaLxWrIZnUB2B1LYL")
                          .set(mcount1)
                          .onError(
                              (e, _) => print("Error writing document: $e"));

                      FirebaseFirestore.instance
                          .collection(widget.user.uid)
                          .doc(widget.user.uid + "model1")
                          .set(likeflag1)
                          .onError(
                              (e, _) => print("Error writing document: $e"));
                    });
                  },
                ),
                Text('$_count1'),
              ],
            ),
          ),

          SizedBox(height: 30),
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
            margin: const EdgeInsets.fromLTRB(80, 0, 50, 0),
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
          Container(
            // padding: const EdgeInsets.all(1.0),
            margin: const EdgeInsets.fromLTRB(0, 0, 100, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    likeModel2 ? Icons.favorite : Icons.favorite_border,
                    color: likeModel2 ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      likeModel2 = !likeModel2;
                      _count2 += likeModel2 ? 1 : -1;

                      final mcount2 = <String, dynamic>{"model2": _count2};
                      final likeflag2 = <String, dynamic>{
                        "modelbool2": likeModel2
                      };
                      FirebaseFirestore.instance
                          .collection("model2likecount")
                          .doc("NgnrwiZLdK6oHHzq4h1F")
                          .set(mcount2)
                          .onError(
                              (e, _) => print("Error writing document: $e"));

                      FirebaseFirestore.instance
                          .collection(widget.user.uid)
                          .doc(widget.user.uid + "model2")
                          .set(likeflag2)
                          .onError(
                              (e, _) => print("Error writing document: $e"));
                    });
                  },
                ),
                Text('$_count2'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
