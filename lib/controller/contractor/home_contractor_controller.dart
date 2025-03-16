import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takatuf/model/project_model.dart';

class HomeContractorController extends GetxController {
  var projects = <ProjectModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('projects').get();
      var projectList = snapshot.docs.map((doc) => ProjectModel.fromMap(doc)).toList();
      projects.value = projectList;
      print("تم جلب المشاريع: ${projects.length}");
    } catch (e) {
      print('Error fetching projects: $e');
    }
  }
}
