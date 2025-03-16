import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  RxList<QueryDocumentSnapshot> messages = <QueryDocumentSnapshot>[].obs;

  // الدالة لإرسال الرسالة
  void sendMessage(String projectId, String userId) {
    if (messageController.text.trim().isEmpty || currentUserId == null) return;

    FirebaseFirestore.instance.collection('chats').add({
      'projectId': projectId,
      'senderId': currentUserId,
      'receiverId': userId,
      'message': messageController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    }).catchError((error) {
      print("❌ خطأ أثناء إرسال الرسالة: $error");
    });

    messageController.clear();
  }

  // دالة لجلب الرسائل
  Stream<List<QueryDocumentSnapshot>> getMessages(String projectId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('projectId', isEqualTo: projectId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
