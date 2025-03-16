import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/instance_manager.dart';
import 'package:takatuf/controller/contractor/contractor_controller.dart';

class ContractorAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ContractorController contractorController = Get.put(ContractorController());

    return Scaffold(
      appBar: AppBar(title: Text("contractorRegistration".tr())),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: contractorController.nameController,
              decoration: InputDecoration(labelText: "name".tr()),
            ),
            TextField(
              controller: contractorController.specialtyController,
              decoration: InputDecoration(labelText: "specialty".tr()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                contractorController.registerContractor();
              },
              child: Text("register".tr()),
            ),
          ],
        ),
      ),
    );
  }
}
