import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'workFlow1.dart';

class ModelChoice extends StatefulWidget {
  // const ModelChoice({Key key}) : super(key: key);

  @override
  State<ModelChoice> createState() => _ModelChoiceState();
}

class _ModelChoiceState extends State<ModelChoice> {
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
            /* decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.green,
                  blurRadius: 10.0,
                  spreadRadius: 10, //New
                ),
              ],
            ),*/
            child: Text("Choose a detector", style: TextStyle(fontSize: 35)),
            margin: const EdgeInsets.fromLTRB(45, 0, 0, 0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.brown)),
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
                    builder: (context) => WorkFlow1(),
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
                    builder: (context) => WorkFlow1(),
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
