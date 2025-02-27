import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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

  /// تحميل اللغة المحفوظة وتحديث `EasyLocalization`
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language') ?? 'en';

    /// تحديث اللغة في `EasyLocalization`
    context.setLocale(Locale(languageCode, ''));
  }

  /// الانتقال إلى الشاشة المناسبة بعد 4 ثوانٍ
  void _navigateToNextScreen() {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SigninScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade700, Colors.purple.shade400],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 200), // شعار التطبيق
              SizedBox(height: 20),
              Text(
                'appName'.tr(), // استخدام `tr()` بشكل صحيح
                style: TextStyle(
                  fontSize: 28, // تكبير الخط
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // جعل النص أبيض ليتناسب مع الخلفية
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
