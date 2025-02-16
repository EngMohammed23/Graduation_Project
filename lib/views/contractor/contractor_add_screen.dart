import 'package:flutter/material.dart';
import 'package:get/get.dart';

// نموذج لتسجيل المقاولين
class ContractorAddScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تسجيل المقاولين")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "الاسم")),
            TextField(controller: specialtyController, decoration: InputDecoration(labelText: "التخصص")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text("تسجيل")),
          ],
        ),
      ),
    );
  }
}