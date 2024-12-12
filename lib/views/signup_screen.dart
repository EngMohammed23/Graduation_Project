import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatuf/views/Signin_screen.dart';

class SignupScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF003366),
        iconTheme: IconThemeData(
          color: Colors.white,
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
                'Create an account',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
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
                    fontSize: 17,
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
                    fontSize: 17,
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
                    fontSize: 17,
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
              SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                ),
                decoration: InputDecoration(
                  hintText: "Confirm your password",
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 17,
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
                ),
                obscureText: true,
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
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    Get.snackbar('Success', 'Account created successfully!',
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    Get.snackbar('Error', 'Passwords do not match!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  }
                },
                child: Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => SigninScreen());
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFF003366).withOpacity(0.4),
                  ),
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
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
