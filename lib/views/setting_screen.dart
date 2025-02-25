import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takatuf/views/list_tile_setting.dart';
import 'signin_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            ListTileSetting(
              title: 'General Settings',
              icon: Icon(Icons.settings, color: Colors.blue),
              nav: () {},
            ),
            Divider(),

            ListTileSetting(
              title: 'Account Settings',
              icon: Icon(Icons.manage_accounts, color: Colors.green),
              nav: () {},
            ),
            Divider(),

            ListTileSetting(
              title: 'Privacy & Terms',
              icon: Icon(Icons.privacy_tip, color: Colors.orange),
              nav: () {},
            ),
            Divider(),

            ListTileSetting(
              title: 'About Us',
              icon: Icon(Icons.info, color: Colors.purple),
              nav: () {},
            ),
            Divider(),

            ListTileSetting(
              title: 'Help',
              icon: Icon(Icons.help, color: Colors.red),
              nav: () {},
            ),
            Divider(),

            ListTileSetting(
              title: 'Feedback',
              icon: Icon(Icons.feedback, color: Colors.teal),
              nav: () {},
            ),
            Divider(),

            ListTileSetting(
              title: 'Change Language',
              icon: Icon(Icons.language, color: Colors.brown),
              nav: () {
                _showLanguageDialog(context);
              },
            ),
            Divider(),

            ListTileSetting(
              title: 'Log Out',
              icon: Icon(Icons.logout, color: Colors.red),
              nav: () {
                _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // دالة تسجيل الخروج
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(() => SigninScreen()); // توجيه المستخدم لصفحة تسجيل الدخول
  }

  // دالة اختيار اللغة
  void _showLanguageDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currentLanguage = prefs.getString('language') ?? 'en';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('English'),
                value: 'en',
                groupValue: currentLanguage,
                onChanged: (value) {
                  _setLanguage(value!);
                  Get.updateLocale(Locale(value, ''));
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text('العربية'),
                value: 'ar',
                groupValue: currentLanguage,
                onChanged: (value) {
                  _setLanguage(value!);
                  Get.updateLocale(Locale(value, ''));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // دالة حفظ اللغة في SharedPreferences
  Future<void> _setLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }
}
