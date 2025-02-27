import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// نموذج لتسجيل المقاولين
class ContractorAddScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("contractorRegistration".tr())),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "name".tr()),
            ),
            TextField(
              controller: specialtyController,
              decoration: InputDecoration(labelText: "specialty".tr()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // من الممكن إضافة منطق تسجيل المقاولين هنا
              },
              child: Text("register".tr()),
            ),
          ],
        ),
      ),
    );
  }
}
