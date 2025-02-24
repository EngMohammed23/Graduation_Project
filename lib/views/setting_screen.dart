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
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            ListTileSetting(
              title: 'General Settings',
              icon: Icon(Icons.settings),
              nav: () {},
            ),
            ListTileSetting(
              title: 'Account Settings',
              icon: Icon(Icons.manage_accounts),
              nav: () {},
            ),
            ListTileSetting(
              title: 'Privacy & Terms',
              icon: Icon(Icons.privacy_tip),
              nav: () {},
            ),
            ListTileSetting(
              title: 'About Us',
              icon: Icon(Icons.import_contacts),
              nav: () {},
            ),
            ListTileSetting(
              title: 'Help ',
              icon: Icon(Icons.help),
              nav: () {},
            ),
            ListTileSetting(
              title: 'Feedback',
              icon: Icon(Icons.feedback),
              nav: () {},
            ),
            ListTileSetting(
              title: 'LogOut',
              icon: Icon(Icons.logout),
              nav: () {
                 // SharedPreferences prefs = await SharedPreferences.getInstance();
                 // await prefs.clear();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/signin_screen',
                      (Route<dynamic> route) => false, // حذف جميع الصفحات السابقة
                );

              },
            ),
          ],
        ),
      ),
    );
  }
}
