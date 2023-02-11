import 'package:flutter/material.dart';
import 'workFlow1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TomatoBlightDetectorFrontPage(),
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: "Bangers",
      ),
    );
  }
}

class TomatoBlightDetectorFrontPage extends StatelessWidget {
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
        children: [
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
              'We will assist you detecting late blight and early blight , a common disease that defects tomato plants. Simply upload a picture of your tomato plant leaf and let me do the rest!',
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkFlow1(),
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
