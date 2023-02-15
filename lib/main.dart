import 'package:fake_image_detector/modelChoice1.dart';
import 'package:fake_image_detector/modelChoiceUser.dart';
import 'package:fake_image_detector/workFlowUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'workFlow1.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FakeImageDetectorFrontPage(),
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: "Bangers",
      ),
    );
  }
}

class FakeImageDetectorFrontPage extends StatefulWidget {
  @override
  _FakeImageDetectorFrontPageState createState() =>
      _FakeImageDetectorFrontPageState();
}

class _FakeImageDetectorFrontPageState
    extends State<FakeImageDetectorFrontPage> {
  Future signIn() async {
    print(
        "ARRRRRRRRRRRRRRRRRRRRRRR YOUUUUUUUUUUUUUUUUUUUUUU THERE !!!!!!!!!!!!!!");

    final GoogleSignInAccount googleSignInAccount =
        await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User user = result.user;
    print(" not moving to other page");
    if (user != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ModelChoiceUser(
                    user: user,
                  )));
    }
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.brown)),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.fromLTRB(50, 0, 20, 10),
              //   padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/images/homePagePic.jpg",
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            // padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.brown)),
            child: Text('Welcome to Deep Fake Detector Arena! ',
                style: TextStyle(
                  //  fontWeight: FontWeight.bold,
                  fontSize: 29,
                  color: Colors.brown[900],
                ),
                textAlign: TextAlign.center),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(10.0),
            // padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.brown)),
            child: Text(
              'We will assist you detecting deep fake images , Users logging with account can will have the privilege to save images with prediction information too which can be viewed as history for that user',
              // style: Theme.of(context).textTheme.bodyText1,
              style: TextStyle(
                  //  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.brown[900]),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              signIn();
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.brown[900],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            child: Container(
              child: Text(
                'Sign In with Google!',
                style: TextStyle(color: Colors.red[50], fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ModelChoice(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.brown[900],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            child: Container(
              child: Text(
                'Continue Without Logging',
                style: TextStyle(color: Colors.red[50], fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
