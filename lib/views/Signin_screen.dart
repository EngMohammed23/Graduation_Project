import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatuf/views/signup_screen.dart';

class SigninScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            color: Colors.white, // لون النص الأبيض
          ),
        ),
        backgroundColor: Color(0xFF003366), // خلفية AppBar
        iconTheme: IconThemeData(
          color: Colors.white, // لون السهم (أيقونة الرجوع)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign in to your account',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
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
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed('/forgot_password');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor:
                        Color(0xFF003366).withOpacity(0.4), // شفافية 40%
                  ),
                  child: Text(
                    'Forgot your Password?',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
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
                onPressed: () {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    Get.snackbar('Success', 'Logged in successfully!',
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    Get.snackbar('Error', 'Please fill in all fields!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withOpacity(0.6),
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'or',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withOpacity(0.6),
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003366).withOpacity(0.6),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  // تسجيل الدخول باستخدام Google
                },
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003366).withOpacity(0.6),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  // تسجيل الدخول باستخدام Apple
                },
                child: Text(
                  'Sign in with Apple',
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
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 12, // النصوص الأخرى
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Color(0xFF003366), // اللون المطلوب
                          decoration: TextDecoration.underline, // خط تحت الكلمة
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => SignupScreen());
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
