import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Pageview3 extends StatelessWidget {
  const Pageview3({super.key});

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
                image: AssetImage('assets/images/three.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Text(
              "trackProgress".tr(), // استبدال النص بـ `tr()`
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

