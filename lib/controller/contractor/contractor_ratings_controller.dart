
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:takatuf/model/contractor/contractor_model.dart';


class ContractorRatingsController extends GetxController {
  var rating = 3.0.obs;  // التقييم الحالي
  var contractors = <ContractorModel>[
    ContractorModel(image: 'assets/images/three.jpg', title: 'contractorName'.tr(), rating: 3.0, name: '', specialty: ''),
    ContractorModel(image: 'assets/images/three.jpg', title: 'contractorName'.tr(), rating: 3.0, name: '', specialty: ''),
    ContractorModel(image: 'assets/images/three.jpg', title: 'contractorName'.tr(), rating: 3.0, name: '', specialty: ''),
    ContractorModel(image: 'assets/images/three.jpg', title: 'contractorName'.tr(), rating: 3.0, name: '', specialty: ''),
  ].obs;

  // دالة لتحديث التقييم
  void updateRating(double newRating) {
    rating.value = newRating;
  }
}
