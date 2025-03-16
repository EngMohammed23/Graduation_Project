import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takatuf/model/project_model.dart';

class HomeOwnerController extends GetxController {
  var userId = Rxn<String>();
  var projects = <ProjectModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchUserId();
    _fetchProjects();
  }

  // جلب الـ userId من Firebase
  Future<void> _fetchUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId.value = user.uid;
    }
  }

  // جلب المشاريع من Firestore
  Future<void> _fetchProjects() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('projects').get();
      projects.assignAll(
        snapshot.docs.map((doc) => ProjectModel.fromMap(doc)).toList(),
      );
    } catch (e) {
      print("Error fetching projects: $e");
    }
  }
}
