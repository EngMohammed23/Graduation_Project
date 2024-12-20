import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatuf/views/create_a_new_password.dart';
import 'package:takatuf/views/forgot_password_screen.dart';
import 'package:takatuf/views/verification_code_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateNewPasswordScreen(),
    );
  }
}
