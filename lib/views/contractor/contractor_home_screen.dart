import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// الشاشة الرئيسية للمقاولين
class ContractorHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("contractorHome".tr())),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "contractors".tr(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
