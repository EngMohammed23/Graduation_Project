import 'package:flutter/material.dart';
import 'package:get/get.dart';

// نموذج لتسجيل المقاولين
class ContractorHomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("هوم المقاولين")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [

         Center(child: Text("أهبناثبايتار",style: TextStyle(fontSize: 20),))
          ],
        ),
      ),
    );
  }
}