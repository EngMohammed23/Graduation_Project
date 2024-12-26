import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatuf/views/Signin_screen.dart';
import 'package:takatuf/views/VerifyMobileScreen.dart';
import 'package:takatuf/views/add_screen.dart';
import 'package:takatuf/views/favorites_screen.dart';
import 'package:takatuf/views/home.dart';
import 'package:takatuf/views/profile_screen.dart';
import 'package:takatuf/views/search_screen.dart';
import 'package:takatuf/views/setting_screen.dart';
import 'package:takatuf/views/signup_screen.dart';
import 'package:takatuf/views/splash.dart';
import 'package:takatuf/views/success_screen.dart';
import 'package:takatuf/views/update_profile_screen.dart';
import 'package:takatuf/views/welcome_screen.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home_screen',
      // home: HomeScreen(),
      routes: {
        '/splash_screen':(context) => SplashScreen(),
        '/home_screen':(context) => HomeScreen(),
        '/home':(context) => Home(),
        '/add_screen':(context) => AddScreen(),
        '/setting_screen':(context) => SettingScreen(),
        '/favorites_screen':(context) => FavoritesScreen(),
        '/profile_screen':(context) => ProfileScreen(),
        '/search_screen':(context) => SearchScreen(),
        '/signin_screen':(context) => SigninScreen(),
        '/signup_screen':(context) => SignupScreen(),
        '/success_screen':(context) => SuccessScreen(onSuccess: () {  },),
        '/update_profile_screen':(context) => UpdateProfileScreen(),
        '/verify_mobile_screen':(context) => VerifyMobileScreen(),
        '/welcome_screen':(context) => WelcomeScreen(),
      },
    );
  }
}
