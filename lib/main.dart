import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:takatuf/views/login/Signin_screen.dart';
import 'package:takatuf/views/login/signup_screen.dart';
import 'package:takatuf/views/others/profile_screen.dart';
import 'package:takatuf/views/others/firebase_options.dart';
import 'package:takatuf/views/splash/splash.dart';
import 'package:takatuf/views/owner/home_screen.dart';
import 'package:takatuf/views/others/setting_screen.dart';
import 'package:takatuf/views/others/favorites_screen.dart';
import 'package:takatuf/views/others/search_screen.dart';
import 'package:takatuf/views/login/success_screen.dart';
import 'package:takatuf/views/others/update_profile_screen.dart';
import 'package:takatuf/views/login/verify_mobile_screen.dart';
import 'package:takatuf/views/splash/welcome_screen.dart';
import 'package:takatuf/views/others/notifications_screen.dart';
import 'package:takatuf/views/contractor/contractor_ratings_screen.dart';
import 'package:takatuf/views/contractor/home_contractor.dart';
import 'package:takatuf/views/contractor/projects_contractor.dart';
import 'package:takatuf/views/owner/project_screen.dart';
import 'package:takatuf/views/owner/create_new_project_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();

  // استرجاع اللغة المحفوظة في SharedPreferences
  String savedLanguageCode = await _getSavedLanguage();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ar', ''), Locale('en', '')],
      path: 'assets/langs', // تحديد مسار ملفات الترجمة
      fallbackLocale: Locale('ar', ''), // تحديد اللغة الافتراضية
      startLocale: Locale(savedLanguageCode, ''), // بدء التطبيق باللغة المحفوظة
      child: MainApp(),
    ),
  );
}

// دالة لاسترجاع اللغة المحفوظة في SharedPreferences
Future<String> _getSavedLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('language') ?? 'ar'; // إذا لم توجد، افتراضيًا الإنجليزية
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.tajawalTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      getPages: [
        GetPage(name: '/splash_screen', page: () => SplashScreen()),
        GetPage(name: '/home_screen', page: () => HomeScreen()),
        GetPage(name: '/project_screen', page: () => ProjectsScreen()),
        GetPage(name: '/home', page: () => HomeContractor()),
        GetPage(name: '/create_new_project_screen', page: () => CreateNewProjectScreen()),
        GetPage(name: '/setting_screen', page: () => SettingScreen()),
        GetPage(name: '/favorites_screen', page: () => FavoritesScreen()),
        GetPage(name: '/search_screen', page: () => SearchScreen()),
        GetPage(name: '/signin_screen', page: () => SigninScreen()),
        GetPage(name: '/signup_screen', page: () => SignupScreen()),
        GetPage(name: '/success_screen', page: () => SuccessScreen(onSuccess: () {})),
        GetPage(name: '/verify_mobile_screen', page: () => VerifyMobileScreen()),
        GetPage(name: '/welcome_screen', page: () => WelcomeScreen()),
        GetPage(name: '/notifications_screen', page: () => NotificationsScreen()),
        GetPage(name: '/contractor_ratings_screen', page: () => ContractorRatingsScreen()),
        GetPage(name: '/projects_contractor', page: () => ProjectsContractor()),
      ],
      locale: context.locale, // تحديد اللغة الحالية بناءً على EasyLocalization
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:takatuf/views/login/Signin_screen.dart';
// import 'package:takatuf/views/login/signup_screen.dart';
// import 'package:takatuf/views/others/profile_screen.dart';
// import 'package:takatuf/views/others/firebase_options.dart';
// import 'package:takatuf/views/splash/splash.dart';
// import 'package:takatuf/views/owner/home_screen.dart';
// import 'package:takatuf/views/others/setting_screen.dart';
// import 'package:takatuf/views/others/favorites_screen.dart';
// import 'package:takatuf/views/others/search_screen.dart';
// import 'package:takatuf/views/login/success_screen.dart';
// import 'package:takatuf/views/others/update_profile_screen.dart';
// import 'package:takatuf/views/login/verify_mobile_screen.dart';
// import 'package:takatuf/views/splash/welcome_screen.dart';
// import 'package:takatuf/views/others/notifications_screen.dart';
// import 'package:takatuf/views/contractor/contractor_ratings_screen.dart';
// import 'package:takatuf/views/contractor/home_contractor.dart';
// import 'package:takatuf/views/contractor/projects_contractor.dart';
// import 'package:takatuf/views/owner/project_screen.dart';
// import 'package:takatuf/views/owner/create_new_project_screen.dart';
// import 'package:get/get.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await EasyLocalization.ensureInitialized(); // تهيئة مكتبة easy_localization
//
//   // استرجاع اللغة المحفوظة في SharedPreferences
//   String savedLanguageCode = await _getSavedLanguage();
//
//   runApp(
//     EasyLocalization(
//       supportedLocales: [Locale('ar', ''), Locale('en', '')],
//       path: 'assets/langs', // تحديد مسار ملفات الترجمة
//       fallbackLocale: Locale('ar', ''), // تحديد اللغة الافتراضية
//       startLocale: Locale(savedLanguageCode, ''), // بدء التطبيق باللغة المحفوظة
//       child: MainApp(),
//     ),
//   );
// }
//
// // دالة لاسترجاع اللغة المحفوظة في SharedPreferences
// Future<String> _getSavedLanguage() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString('language') ?? 'ar'; // إذا لم توجد، افتراضيًا الإنجليزية
// }
//
// class MainApp extends StatelessWidget {
//   const MainApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       // translations: MyTranslations(), // تأكد من وجود كائن الترجمة
//       theme: ThemeData(
//         textTheme: GoogleFonts.tajawalTextTheme(),
//       ),
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/splash_screen',
//       getPages: [
//         GetPage(name: '/splash_screen', page: () => SplashScreen()),
//         GetPage(name: '/home_screen', page: () => HomeScreen()),
//         GetPage(name: '/project_screen', page: () => ProjectsScreen()),
//         GetPage(name: '/home', page: () => HomeContractor()),
//         GetPage(name: '/create_new_project_screen', page: () => CreateNewProjectScreen()),
//         GetPage(name: '/setting_screen', page: () => SettingScreen()),
//         GetPage(name: '/favorites_screen', page: () => FavoritesScreen()),
//         GetPage(name: '/search_screen', page: () => SearchScreen()),
//         GetPage(name: '/signin_screen', page: () => SigninScreen()),
//         GetPage(name: '/signup_screen', page: () => SignupScreen()),
//         GetPage(name: '/success_screen', page: () => SuccessScreen(onSuccess: () {})),
//         GetPage(name: '/verify_mobile_screen', page: () => VerifyMobileScreen()),
//         GetPage(name: '/welcome_screen', page: () => WelcomeScreen()),
//         GetPage(name: '/notifications_screen', page: () => NotificationsScreen()),
//         GetPage(name: '/contractor_ratings_screen', page: () => ContractorRatingsScreen()),
//         GetPage(name: '/projects_contractor', page: () => ProjectsContractor()),
//       ],
//       locale: context.locale, // تحديد اللغة الحالية بناءً على EasyLocalization
//       supportedLocales: context.supportedLocales,
//       localizationsDelegates: context.localizationDelegates,
//     );
//   }
// }
