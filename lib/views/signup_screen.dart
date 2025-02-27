import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
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
  String userType = "Owner"; // Default user type
  bool isPasswordHidden = true;

  Future<void> _registerUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String fullName = nameController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || fullName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("fillAllFields".tr()), backgroundColor: Colors.red),
      );
      return;
    }

    RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("invalidEmail".tr()), backgroundColor: Colors.red),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("passwordMismatch".tr()), backgroundColor: Colors.red),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("weakPassword".tr()), backgroundColor: Colors.red),
      );
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("accountCreated".tr()), backgroundColor: Colors.green),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninScreen()));
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      String errorMessage = "errorOccurred".tr();

      if (e.code == 'email-already-in-use') {
        errorMessage = "emailAlreadyInUse".tr();
      } else if (e.code == 'weak-password') {
        errorMessage = "weakPassword".tr();
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
        title: Text('signUp'.tr(), style: TextStyle(fontSize: 18, fontFamily: 'Poppins', color: Colors.black)),
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
              Text('createAccount'.tr(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'fullName'.tr(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
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
              DropdownButtonFormField<String>(
                value: userType,
                items: [
                  DropdownMenuItem(value: "Owner", child: Text("projectOwner".tr())),
                  DropdownMenuItem(value: "Contractor", child: Text("contractor".tr())),
                  DropdownMenuItem(value: "Worker", child: Text("worker".tr())),
                ],
                onChanged: (value) {
                  setState(() {
                    userType = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'userType'.tr(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
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
              SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: 'confirmPassword'.tr(),
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
                child: Text('createAccount'.tr(), style: TextStyle(color: Colors.white)),
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
// import 'package:cloud_firestore/cloud_firestore.dart';
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
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   String userType = "Owner"; // Default to Project Owner
//   bool isPasswordHidden = true;
//
//   Future<void> _registerUser() async {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     String confirmPassword = confirmPasswordController.text.trim();
//     String fullName = nameController.text.trim();
//
//     if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || fullName.isEmpty) {
//       Get.snackbar('Error', 'Please fill in all fields!',
//           snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     // Check if email is valid
//     RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
//     if (!emailRegex.hasMatch(email)) {
//       Get.snackbar('Error', 'Invalid email format!',
//           snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     if (password != confirmPassword) {
//       Get.snackbar('Error', 'Passwords do not match!',
//           snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     // Check if password is strong enough
//     if (password.length < 6) {
//       Get.snackbar('Error', 'Password must be at least 6 characters long!',
//           snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => Center(child: CircularProgressIndicator(color: Color(0xFF003366))),
//       );
//
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       await _firestore.collection("users").doc(userCredential.user!.uid).set({
//         "fullName": fullName,
//         "email": email,
//         "userType": userType,
//         "uid": userCredential.user!.uid,
//       });
//
//       Navigator.of(context).pop();
//
//       Get.snackbar('Success', 'Account created successfully!',
//           snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
//
//       // Get.to(() => VerifyMobileScreen());
//        Get.to(() => SigninScreen());
//
//     } on FirebaseAuthException catch (e) {
//       Navigator.of(context).pop();
//       print('Error Code: ${e.code}');
//       print('Error Message: ${e.message}');
//       String errorMessage = "An error occurred";
//       if (e.code == 'email-already-in-use') {
//         errorMessage = "This email is already registered.";
//       } else if (e.code == 'weak-password') {
//         errorMessage = "Password is too weak.";
//       } else if (e.code == 'invalid-email') {
//         errorMessage = "Invalid email format.";
//       }
//
//       Get.snackbar('Registration Failed', errorMessage,
//           snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up', style: TextStyle(fontSize: 18, fontFamily: 'Poppins', color: Colors.black)),
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
//               DropdownButtonFormField<String>(
//                 value: userType,
//                 items: [
//                   DropdownMenuItem(value: "Owner", child: Text("Project Owner")),
//                   DropdownMenuItem(value: "Contractor", child: Text("Contractor")),
//                   DropdownMenuItem(value: "Worker", child: Text("Worker")),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     userType = value!;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'User Type',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//                 ),
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
