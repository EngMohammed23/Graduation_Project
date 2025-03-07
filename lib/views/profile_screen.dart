import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takatuf/views/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userId;
  Map<String, dynamic> userData = {
    "fullName": "مستخدم افتراضي",
    "email": "exam@gmail.com",
    "phoneNumber": "غير متوفر",
    "userType": "غير محدد",
  };

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  /// تحميل UID من SharedPreferences
  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedUid = prefs.getString('userId'); // جلب UID المحفوظ
    if (storedUid != null) {
      setState(() {
        userId = storedUid;
      });
      _fetchUserData(storedUid);
    }
  }

  /// جلب بيانات المستخدم من Firestore باستخدام UID
  Future<void> _fetchUserData(String uid) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: const Color(0XFF003366),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
              );
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/setting_screen');
            },
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 220,
            decoration: const BoxDecoration(
              color: Color(0XFF003366),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                ClipOval(
                  child: Image.asset(
                    "assets/images/three.jpg",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  userData["fullName"] ?? "غير متوفر",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text('email'.tr(), style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 3),
                Text(userData["email"] ?? "غير متوفر", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 15),
                Text('phoneNumber'.tr(), style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 3),
                Text(userData["phoneNumber"] ?? "غير متوفر", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 15),
                Text('userType'.tr(), style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 3),
                Text(userData["userType"] ?? "غير متوفر", style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
