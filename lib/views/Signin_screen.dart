import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:takatuf/views/contractor/home_contractor.dart';
import 'package:takatuf/views/home_screen.dart';
import 'package:takatuf/views/signup_screen.dart';
import 'package:takatuf/views/worker_home_screen.dart';

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

  Future<void> saveUserData(User user, String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.uid);
    await prefs.setString('userType', userType);
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> _signInUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("fillAllFields".tr()), backgroundColor: Colors.red),
      );
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(color: Color(0xFF003366))),
      );

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firestore.collection("users").doc(userCredential.user!.uid).get();
      String userType = userDoc["userType"];

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("loginSuccess".tr()), backgroundColor: Colors.green),
      );

      await saveUserData(userCredential.user!, userType);

      Widget nextScreen;
      if (userType == "Owner") {
        nextScreen = HomeScreen();
      } else if (userType == "Worker") {
        nextScreen = WorkerHomeScreen();
      } else {
        nextScreen = HomeContractor();
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextScreen));
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      String errorMessage = "errorOccurred".tr();

      if (e.code == 'user-not-found') {
        errorMessage = "userNotFound".tr();
      } else if (e.code == 'wrong-password') {
        errorMessage = "wrongPassword".tr();
      } else if (e.code == 'invalid-email') {
        errorMessage = "invalidEmail".tr();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('signIn'.tr(), style: TextStyle(fontSize: 18, fontFamily: 'Poppins', color: Colors.black)),
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
              Text('signInToYourAccount'.tr(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'email'.tr(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: 'password'.tr(),
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
                  child: Text('forgotPassword'.tr(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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
                child: Text('signIn'.tr(), style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    text: 'noAccount'.tr(),
                    children: [
                      TextSpan(
                        text: 'signUp'.tr(),
                        style: TextStyle(color: Color(0xFF003366), decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                        },
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


