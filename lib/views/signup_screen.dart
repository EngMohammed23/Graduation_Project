import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takatuf/views/signin_screen.dart';
import 'package:takatuf/views/verify_mobile_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String userType = "Owner"; // Default to Project Owner
  bool isPasswordHidden = true;

  Future<void> _registerUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String fullName = nameController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || fullName.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Check if email is valid
    RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      Get.snackbar('Error', 'Invalid email format!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Check if password is strong enough
    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters long!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(color: Color(0xFF003366))),
      );

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "fullName": fullName,
        "email": email,
        "userType": userType,
        "uid": userCredential.user!.uid,
      });

      Navigator.of(context).pop();

      Get.snackbar('Success', 'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);

      Get.to(() => VerifyMobileScreen());
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      print('Error Code: ${e.code}');
      print('Error Message: ${e.message}');
      String errorMessage = "An error occurred";
      if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already registered.";
      } else if (e.code == 'weak-password') {
        errorMessage = "Password is too weak.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      }

      Get.snackbar('Registration Failed', errorMessage,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(fontSize: 18, fontFamily: 'Poppins', color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF003366)),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          left: 16.0,
          right: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create an account', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: userType,
                items: [
                  DropdownMenuItem(value: "Owner", child: Text("Project Owner")),
                  DropdownMenuItem(value: "Contractor", child: Text("Contractor")),
                  DropdownMenuItem(value: "Worker", child: Text("Worker")),
                ],
                onChanged: (value) {
                  setState(() {
                    userType = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'User Type',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordHidden ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => isPasswordHidden = !isPasswordHidden),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003366),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                ),
                onPressed: _registerUser,
                child: Text('Create an Account', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(color: Color(0xFF003366), decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () => Get.to(() => SigninScreen()),
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



// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:takatuf/views/signin_screen.dart';
// import 'package:takatuf/views/verify_mobile_screen.dart';
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth Instance
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   bool isPasswordHidden = true;
//
//   // **Function to Register a User**
//   Future<void> _registerUser() async {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     String confirmPassword = confirmPasswordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
//       Get.snackbar('Error', 'Please fill in all fields!',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white);
//       return;
//     }
//
//     if (password != confirmPassword) {
//       Get.snackbar('Error', 'Passwords do not match!',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white);
//       return;
//     }
//
//     try {
//       // **Show loading indicator**
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => Center(
//           child: CircularProgressIndicator(color: Color(0xFF003366)),
//         ),
//       );
//
//       // **Create a new user in Firebase Authentication**
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       Navigator.of(context).pop(); // Close loading indicator
//
//       if (userCredential.user != null) {
//         Get.snackbar('Success', 'Account created successfully!',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.green,
//             colorText: Colors.white);
//
//         // Navigate to the verification screen
//         Get.to(() => VerifyMobileScreen());
//       }
//     } on FirebaseAuthException catch (e) {
//       Navigator.of(context).pop(); // Close loading indicator
//       String errorMessage = "An error occurred";
//
//       if (e.code == 'email-already-in-use') {
//         errorMessage = "This email is already registered.";
//       } else if (e.code == 'weak-password') {
//         errorMessage = "Password is too weak.";
//       } else if (e.code == 'invalid-email') {
//         errorMessage = "Invalid email format.";
//       }
//
//       Get.snackbar('Registration Failed', errorMessage,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Sign Up',
//           style: TextStyle(fontSize: 18, fontFamily: 'Poppins', color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Color(0xFF003366)),
//         elevation: 0,
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.only(
//           top: MediaQuery.of(context).size.height * 0.05,
//           left: 16.0,
//           right: 16.0,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Create an account', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
//               SizedBox(height: 20),
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Full Name',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: passwordController,
//                 obscureText: isPasswordHidden,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//                   suffixIcon: IconButton(
//                     icon: Icon(isPasswordHidden ? Icons.visibility_off : Icons.visibility),
//                     onPressed: () => setState(() => isPasswordHidden = !isPasswordHidden),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: confirmPasswordController,
//                 obscureText: isPasswordHidden,
//                 decoration: InputDecoration(
//                   labelText: 'Confirm Password',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//                 ),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF003366),
//                   minimumSize: Size(double.infinity, 60),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//                 ),
//                 onPressed: _registerUser,
//                 child: Text('Create an Account', style: TextStyle(color: Colors.white)),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.center,
//                 child: Text.rich(
//                   TextSpan(
//                     text: 'Already have an account? ',
//                     children: [
//                       TextSpan(
//                         text: 'Login',
//                         style: TextStyle(color: Color(0xFF003366), decoration: TextDecoration.underline),
//                         recognizer: TapGestureRecognizer()..onTap = () => Get.to(() => SigninScreen()),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
