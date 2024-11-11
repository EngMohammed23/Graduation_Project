import 'package:flutter/material.dart';

class Pageview3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            alignment: Alignment.centerRight,
          ),
          Container(
            width: 350,
            height: 450,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/three.jpg',
                    ),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),
          Container(
              margin: EdgeInsets.only(top: 40),
              child: Text("Track progress and payments intelligently"))
        ],
      ),
    );
  }
}
