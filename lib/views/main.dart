import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'package:takatuf/views/localizations.dart';
import 'package:takatuf/views/splash/splash.dart';
import 'package:takatuf/views/signin_screen.dart';
import 'package:takatuf/views/signup_screen.dart';
import 'package:takatuf/views/home_screen.dart';
import 'package:takatuf/views/project_management_screen.dart';
import 'package:takatuf/views/setting_screen.dart';
import 'package:takatuf/views/favorites_screen.dart';
import 'package:takatuf/views/profile_screen.dart';
import 'package:takatuf/views/search_screen.dart';
import 'package:takatuf/views/success_screen.dart';
import 'package:takatuf/views/update_profile_screen.dart';
import 'package:takatuf/views/verify_mobile_screen.dart';
import 'package:takatuf/views/welcome_screen.dart';
import 'package:takatuf/views/notifications_screen.dart';
import 'package:takatuf/views/contractor/contractor_ratings_screen.dart';
import 'package:takatuf/views/contractor/home_contractor.dart';
import 'package:takatuf/views/contractor/projects_contractor.dart';
import 'package:takatuf/views/contractor/test_screen.dart';
import 'package:takatuf/views/owner/edit_project_screen.dart';
import 'package:takatuf/views/owner/project_screen.dart';
import 'package:takatuf/views/owner/create_new_project_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String languageCode = await _getLanguage();
  Get.updateLocale(Locale(languageCode));  // تأكد من تحديث اللغة هنا
  runApp(MainApp(languageCode: languageCode));
  }

// دالة لاسترجاع اللغة من SharedPreferences
Future<String> _getLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('language') ?? 'en';
}

class MainApp extends StatelessWidget {
  final String languageCode;
  const MainApp({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => SplashScreen(),
        '/home_screen': (context) => HomeScreen(),
        '/project_screen': (context) => ProjectsScreen(),
        '/home': (context) => HomeContractor(),
        '/test': (context) => ProjectsAndWorkersScreen(),
        '/project_management_screen': (context) => ProjectManagementScreen(),
        '/create_new_project_screen': (context) => CreateNewProjectScreen(),
        '/setting_screen': (context) => SettingScreen(),
        '/favorites_screen': (context) => FavoritesScreen(),
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
        '/projects_contractor': (context) => ProjectsContractor(),
      },
      locale: Locale(languageCode),
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate,
      ],
    );
  }
}
