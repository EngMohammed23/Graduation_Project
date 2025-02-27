import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takatuf/views/list_tile_setting.dart';
import 'signin_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            _buildSettingTile('generalSettings'.tr(), Icons.settings, Colors.blue, () {}),
            _divider(),
            _buildSettingTile('accountSettings'.tr(), Icons.manage_accounts, Colors.green, () {}),
            _divider(),
            _buildSettingTile('privacyTerms'.tr(), Icons.privacy_tip, Colors.orange, () {}),
            _divider(),
            _buildSettingTile('aboutUs'.tr(), Icons.info, Colors.purple, () {}),
            _divider(),
            _buildSettingTile('help'.tr(), Icons.help, Colors.red, () {}),
            _divider(),
            _buildSettingTile('feedback'.tr(), Icons.feedback, Colors.teal, () {}),
            _divider(),
            _buildSettingTile('changeLanguage'.tr(), Icons.language, Colors.brown, () => _showLanguageDialog(context)),
            _divider(),
            _buildSettingTile('logOut'.tr(), Icons.logout, Colors.red, () => _logout(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(String title, IconData icon, Color color, VoidCallback onTap) {
    return ListTileSetting(
      title: title,
      icon: Icon(icon, color: color),
      nav: onTap,
    );
  }

  Widget _divider() => Divider();

  // دالة تسجيل الخروج
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SigninScreen()),
    );
  }

  // دالة اختيار اللغة
  void _showLanguageDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentLanguage = prefs.getString('language') ?? 'en';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('chooseLanguage'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('English', 'en', currentLanguage, context),
              _buildLanguageOption('العربية', 'ar', currentLanguage, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language, String code, String currentLanguage, BuildContext context) {
    return RadioListTile<String>(
      title: Text(language),
      value: code,
      groupValue: currentLanguage,
      onChanged: (value) {
        _setLanguage(value!, context);
        Navigator.pop(context);
      },
    );
  }

  // دالة حفظ اللغة في SharedPreferences وتحديث التطبيق
  Future<void> _setLanguage(String languageCode, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    context.setLocale(Locale(languageCode, '')); // تحديث اللغة أثناء التشغيل
  }
}


// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:takatuf/views/list_tile_setting.dart';
// import 'signin_screen.dart';
//
// class SettingScreen extends StatelessWidget {
//   const SettingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('settings'.tr(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(Icons.arrow_back),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: ListView(
//           children: [
//             _buildSettingTile('generalSettings'.tr(), Icons.settings, Colors.blue, () {}),
//             _divider(),
//             _buildSettingTile('accountSettings'.tr(), Icons.manage_accounts, Colors.green, () {}),
//             _divider(),
//             _buildSettingTile('privacyTerms'.tr(), Icons.privacy_tip, Colors.orange, () {}),
//             _divider(),
//             _buildSettingTile('aboutUs'.tr(), Icons.info, Colors.purple, () {}),
//             _divider(),
//             _buildSettingTile('help'.tr(), Icons.help, Colors.red, () {}),
//             _divider(),
//             _buildSettingTile('feedback'.tr(), Icons.feedback, Colors.teal, () {}),
//             _divider(),
//             _buildSettingTile('changeLanguage'.tr(), Icons.language, Colors.brown, () => _showLanguageDialog(context)),
//             _divider(),
//             _buildSettingTile('logOut'.tr(), Icons.logout, Colors.red, () => _logout(context)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSettingTile(String title, IconData icon, Color color, VoidCallback onTap) {
//     return ListTileSetting(
//       title: title,
//       icon: Icon(icon, color: color),
//       nav: onTap,
//     );
//   }
//
//   Widget _divider() => Divider();
//
//   // دالة تسجيل الخروج
//   void _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninScreen())); // توجيه المستخدم لصفحة تسجيل الدخول
//   }
//
//   // دالة اختيار اللغة
//   void _showLanguageDialog(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String currentLanguage = prefs.getString('language') ?? 'en';
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('chooseLanguage'.tr()),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildLanguageOption('English', 'en', currentLanguage, context),
//               _buildLanguageOption('العربية', 'ar', currentLanguage, context),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildLanguageOption(String language, String code, String currentLanguage, BuildContext context) {
//     return RadioListTile<String>(
//       title: Text(language),
//       value: code,
//       groupValue: currentLanguage,
//       onChanged: (value) {
//         _setLanguage(value!, context);
//         Navigator.pop(context);
//       },
//     );
//   }
//
//   // دالة حفظ اللغة في SharedPreferences وتحديث التطبيق
//   Future<void> _setLanguage(String languageCode, BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('language', languageCode);
//     context.setLocale(Locale(languageCode, '')); // تحديث اللغة أثناء التشغيل
//   }
// }

