import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController {
  final String userId;

  ProfileController({required this.userId});

  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      return docSnapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      print("Error fetching data: $e");
      return null;
    }
  }

  Future<void> updateUserProfile(String name, String phone) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'fullName': name,
        'phoneNumber': phone,
      });
    } catch (e) {
      print("Error updating profile: $e");
    }
  }
}
