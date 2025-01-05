import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatuf/views/Signin_screen.dart';
import 'package:takatuf/views/contractor_ratings_screen.dart';
import 'package:takatuf/views/create_new_project_screen.dart';
import 'package:takatuf/views/favorites_screen.dart';
import 'package:takatuf/views/home.dart';
import 'package:takatuf/views/notifications_screen.dart';
import 'package:takatuf/views/profile_screen.dart';
import 'package:takatuf/views/project_details_screen.dart';
import 'package:takatuf/views/project_management_screen.dart';
import 'package:takatuf/views/search_screen.dart';
import 'package:takatuf/views/setting_screen.dart';
import 'package:takatuf/views/signup_screen.dart';
import 'package:takatuf/views/splash.dart';
import 'package:takatuf/views/success_screen.dart';
import 'package:takatuf/views/update_profile_screen.dart';
import 'package:takatuf/views/verify_mobile_screen.dart';
import 'package:takatuf/views/welcome_screen.dart';
import 'package:takatuf/views/home_screen.dart';
import 'package:takatuf/views/create_a_new_password.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/contractor_ratings_screen', // يمكن تعديلها حسب الحاجة
      home: CreateNewPasswordScreen(), // يمكن استخدام home أو initialRoute فقط
      routes: {
        '/splash_screen': (context) => SplashScreen(),
        '/home_screen': (context) => HomeScreen(),
        '/home': (context) => Home(),
        '/project_management_screen': (context) => ProjectManagementScreen(),
        '/create_new_project_screen': (context) => CreateNewProjectScreen(),
        '/setting_screen': (context) => SettingScreen(),
        '/favorites_screen': (context) => FavoritesScreen(),
        '/project_details_screen': (context) => ProjectDetailsScreen(),
        '/profile_screen': (context) => ProfileScreen(),
        '/search_screen': (context) => SearchScreen(),
        '/signin_screen': (context) => SigninScreen(),
        '/signup_screen': (context) => SignupScreen(),
        '/success_screen': (context) => SuccessScreen(onSuccess: () {}),
        '/update_profile_screen': (context) => UpdateProfileScreen(),
        '/verify_mobile_screen': (context) => VerifyMobileScreen(),
        '/welcome_screen': (context) => WelcomeScreen(),
        '/notifications_screen': (context) => Notifications_Screen(),
        '/contractor_ratings_screen': (context) => ContractorRatingsScreen(),
      },
    );
  }
}
