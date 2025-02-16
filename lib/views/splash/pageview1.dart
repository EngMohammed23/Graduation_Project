import 'package:flutter/material.dart';

class Pageview1 extends StatelessWidget {
  const Pageview1({super.key});

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
                      'assets/images/one.jpg',
                    ),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),
          Container(
              margin: EdgeInsets.only(top: 40),
              child: Text("Manage your projects effortlessly"))
        ],
      ),
    );
  }
}
