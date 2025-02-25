import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takatuf/views/home_screen.dart';
import 'package:takatuf/views/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _navigateToNextScreen();
  }

  /// تحميل اللغة المحفوظة وتحديث `GetX` باللغة الصحيحة
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language') ?? 'en';
    Get.updateLocale(Locale(languageCode));
  }

  /// الانتقال إلى الشاشة المناسبة بعد 3 ثوانٍ
  void _navigateToNextScreen() {
    Timer(Duration(seconds: 3), () {
      Get.off(() => SigninScreen()); // انتقل لصفحة تسجيل الدخول بعد 3 ثواني
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 150),
            SizedBox(height: 20),
            Text(
              'appName'.tr, // يتم الترجمة بناءً على اللغة المختارة
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
