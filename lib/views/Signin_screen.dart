import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takatuf/views/contractor/home_contractor.dart';
import 'package:takatuf/views/home_screen.dart';
import 'package:takatuf/views/signup_screen.dart';
import 'package:takatuf/views/worker_home_screen.dart';
import 'localizations.dart';  // تأكد من إضافة ملف الترجمات هنا

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordHidden = true;

  // دالة لحفظ بيانات المستخدم في shared_preferences
  Future<void> saveUserData(User user, String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.uid);
    await prefs.setString('userType', userType);
    await prefs.setBool('isLoggedIn', true);
  }

  // دالة لتسجيل دخول المستخدم
  Future<void> _signInUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error'.tr, 'Please fill in all fields!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(color: Color(0xFF003366)),
        ),
      );

      // تسجيل الدخول باستخدام Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // الحصول على بيانات المستخدم من Firestore
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(userCredential.user!.uid).get();
      String userType = userDoc["userType"];

      Navigator.of(context).pop();

      Get.snackbar('Success'.tr, 'Login successful!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

      // حفظ بيانات المستخدم في shared_preferences
      await saveUserData(userCredential.user!, userType);

      // التوجيه إلى الصفحة المناسبة بناءً على نوع المستخدم
      if (userType == "Owner") {
        Get.to(() => HomeScreen());
      } else if (userType == "Worker") {
        Get.to(() => WorkerHomeScreen());
      } else {
        Get.to(() => HomeContractor());
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      String errorMessage = "An error occurred".tr;
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for this email.".tr;
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.".tr;
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.".tr;
      }

      Get.snackbar('Login Failed'.tr, errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'.tr, style: TextStyle(fontSize: 18, fontFamily: 'Poppins', color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign in to your account'.tr, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email'.tr,
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: 'Password'.tr,
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordHidden ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => isPasswordHidden = !isPasswordHidden),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot your Password?'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003366),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                ),
                onPressed: _signInUser,
                child: Text('Sign In'.tr, style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? '.tr,
                    children: [
                      TextSpan(
                        text: 'Sign Up'.tr,
                        style: TextStyle(color: Color(0xFF003366), decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () => Get.to(() => SignupScreen()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
