import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatuf/views/signin_screen.dart';
import 'package:takatuf/views/verify_mobile_screen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordHidden = true; // للتحكم في عرض/إخفاء كلمة المرور

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            color: Colors.black, // لون النص أسود
          ),
        ),
        backgroundColor: Colors.white, // خلفية AppBar بيضاء
        iconTheme: IconThemeData(
          color: Color(0xFF003366), // لون السهم
        ),
        elevation: 0, // إزالة الظل أسفل الـ AppBar
      ),
      backgroundColor: Colors.white, // خلفية الشاشة بالكامل بيضاء
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height *
              0.05, // إضافة Margin من الأعلى
          left: 16.0,
          right: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create an account',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                ),
                decoration: InputDecoration(
                  hintText: "Enter your full name",
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                ),
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden, // التحكم في عرض/إخفاء النص
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                ),
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off // أيقونة الإخفاء
                          : Icons.visibility, // أيقونة العرض
                      color: Colors.grey.withOpacity(0.6), // شفافية 60%
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden; // تبديل الحالة
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                obscureText: isPasswordHidden, // التحكم في عرض/إخفاء النص
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                ),
                decoration: InputDecoration(
                  hintText: "Confirm your password",
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off // أيقونة الإخفاء
                          : Icons.visibility, // أيقونة العرض
                      color: Colors.grey.withOpacity(0.6), // شفافية 60%
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden; // تبديل الحالة
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003366),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    Get.snackbar('Error', 'Please fill in all fields!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    Get.snackbar('Error', 'Passwords do not match!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  } else {
                    // عرض Spinner عند بدء العملية
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF003366),
                          ),
                        );
                      },
                    );

                    await Future.delayed(
                        Duration(seconds: 2)); // محاكاة التأخير
                    Navigator.of(context).pop(); // إغلاق الـ Spinner
                    Get.to(() => VerifyMobileScreen());
                  }
                },
                child: Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account ',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Color(0xFF003366),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => SigninScreen());
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
