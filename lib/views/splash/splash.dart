import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takatuf/views/Signin_screen.dart';
import 'package:takatuf/views/home_screen.dart';
import 'package:takatuf/views/worker_home_screen.dart';
import 'package:takatuf/views/contractor/home_contractor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

Future<void> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn = prefs.getBool('isLoggedIn');

  if (isLoggedIn != null && isLoggedIn) {
    String? userId = prefs.getString('userId');
    String? userType = prefs.getString('userType');

    if (userId != null && userType != null) {
      // توجيه المستخدم إلى الشاشة المناسبة بناءً على نوع المستخدم
      if (userType == "Owner") {
        Get.off(() => HomeScreen());
      } else if (userType == "Worker") {
        Get.off(() => WorkerHomeScreen());
      } else {
        Get.off(() => HomeContractor());
      }
    }
  } else {
    // إذا لم يكن المستخدم مسجلًا، توجيهه إلى شاشة تسجيل الدخول
    Get.off(() => SigninScreen());
  }
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    Timer(Duration(seconds: 3), () {
      checkLoginStatus(); // التحقق من حالة تسجيل الدخول
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF003366),
              Color(0xFFA1B0BF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png', // Replace with your logo asset path
                      width: 300,
                      height: 300,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'TAKATUF',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:takatuf/views/home_screen.dart';
// import 'package:takatuf/views/worker_home_screen.dart';
// import 'package:takatuf/views/contractor/home_contractor.dart';
// import 'package:takatuf/views/signin_screen.dart';
//
// Future<void> checkLoginStatus() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? uid = prefs.getString("userId");
//   String? userType = prefs.getString("userType");
//
//   if (uid != null && userType != null) {
//     if (userType == "Owner") {
//       Get.off(() => HomeScreen());
//     } else if (userType == "Worker") {
//       Get.off(() => WorkerHomeScreen());
//     } else {
//       Get.off(() => HomeContractor());
//     }
//   } else {
//     Get.off(() => SigninScreen());
//   }
// }
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     );
//
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//
//     _animationController.forward();
//
//     Timer(Duration(seconds: 3), () {
//       checkLoginStatus();
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF003366),
//               Color(0xFFA1B0BF),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FadeTransition(
//                 opacity: _animation,
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       'assets/images/logo.png', // Replace with your logo asset path
//                       width: 300,
//                       height: 300,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'TAKATUF',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

