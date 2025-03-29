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
  }

  // جلب الـ userId من Firebase
  Future<void> _fetchUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId.value = user.uid;
      await _fetchProjects(); // تنفيذ جلب المشاريع بعد تعيين الـ userId
    }
  }

  // جلب المشاريع من Firestore
  Future<void> _fetchProjects() async {
    if (userId.value == null) return; // التأكد من أن الـ userId تم تعيينه

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('projects')
          .where('userId', isEqualTo: userId.value) // استخدام userId.value
          .get();
      projects.assignAll(
        snapshot.docs.map((doc) => ProjectModel.fromMap(doc.data() as DocumentSnapshot<Object?>)).toList(),
      );
    } catch (e) {
      print("Error fetching projects: $e");
    }
  }
}
