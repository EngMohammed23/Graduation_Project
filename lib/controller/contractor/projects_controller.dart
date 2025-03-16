import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takatuf/model/project_model.dart';

class ProjectsController extends GetxController {
  var projects = <ProjectModel>[].obs;
  var userId = Rx<String?>(null);
  var email = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    _fetchUserId();
    _fetchProjects();
  }

  // دالة لجلب المشاريع من Firebase
  Future<void> _fetchProjects() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('projects').get();
      var projectList = snapshot.docs.map((doc) => ProjectModel.fromMap(doc)).toList();
      projects.value = projectList;
    } catch (e) {
      print("Error fetching projects: $e");
    }
  }

  // دالة لجلب معرف المستخدم
  Future<void> _fetchUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId.value = user.uid;
      email.value = user.email;
    }
  }
}
