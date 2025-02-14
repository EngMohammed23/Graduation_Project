import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:takatuf/views/home_screen.dart';
import 'package:takatuf/views/splash.dart';
import 'package:takatuf/views/signin_screen.dart';
import 'package:takatuf/views/signup_screen.dart';
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
import 'package:takatuf/views/success_screen.dart';
import 'package:takatuf/views/update_profile_screen.dart';
import 'package:takatuf/views/verify_mobile_screen.dart';
import 'package:takatuf/views/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // **تهيئة Firebase**
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      home: SplashScreen(),
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
        '/notifications_screen': (context) => NotificationsScreen(),
        '/contractor_ratings_screen': (context) => ContractorRatingsScreen(),
      },
    );
  }
}
