import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:takatuf/model/contractor/contractor_model.dart';


class ContractorController extends GetxController {
  var nameController = TextEditingController();
  var specialtyController = TextEditingController();

  // متغير لتخزين المقاول الجديد
  var contractor = Rx<ContractorModel?>(null);

  // دالة لتسجيل المقاول
  void registerContractor() {
    String name = nameController.text.trim();
    String specialty = specialtyController.text.trim();

    if (name.isEmpty || specialty.isEmpty) {
      Get.snackbar("Error", "All fields are required".tr);
      return;
    }

    contractor.value = ContractorModel(name: name, specialty: specialty, title: '', image: '', rating: null);

    // يمكن إضافة منطق إضافي هنا مثل إرسال البيانات إلى الخادم أو قاعدة البيانات
    Get.snackbar("Success", "Contractor Registered Successfully".tr);
  }

  @override
  void onClose() {
    nameController.dispose();
    specialtyController.dispose();
    super.onClose();
  }
}
