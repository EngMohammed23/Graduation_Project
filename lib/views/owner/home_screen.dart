import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart'; // استيراد Firebase Authentication
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:takatuf/model/owner/home_screen_controller.dart';
import 'package:takatuf/views/others/profile_screen.dart';
import 'create_new_project_screen.dart';
import 'home_owner_screen.dart';
import '../others/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController()); // استخدام GetX Controller لإدارة الحالة

    // استرجاع الـ userId من Firebase Authentication
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    final List<Widget> _list = [
      HomeOwnerScreen(),
      SearchScreen(),
      CreateNewProjectScreen(),
      ProfileScreen(userId: userId), // تمرير الـ userId إلى ProfileScreen
    ];

    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value, // استخدام GetX لإدارة currentIndex
          onTap: (value) {
            controller.changeTabIndex(value); // تغيير التبويب باستخدام GetX
          },
          backgroundColor: const Color(0xFF003366),
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.home, 0, controller),
              label: 'home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.search, 1, controller),
              label: 'search'.tr(),
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.add_circle_outline, 2, controller),
              label: 'add'.tr(),
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.person, 3, controller),
              label: 'profile'.tr(),
            ),
          ],
        );
      }),
      body: Obx(() {
        return _list.elementAt(controller.currentIndex.value); // عرض الصفحة بناءً على currentIndex
      }),
    );
  }

  Widget _buildCustomIcon(IconData icon, int index, HomeScreenController controller) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: controller.currentIndex.value == index ? Colors.white : Colors.transparent,
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        color: controller.currentIndex.value == index ? const Color(0xFF003366) : Colors.white,
        size: 28,
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:get/get.dart';
// import 'package:takatuf/model/owner/home_screen_controller.dart';
// import 'package:takatuf/views/others/profile_screen.dart';
// import 'create_new_project_screen.dart';
// import 'home_owner_screen.dart';
// import '../others/search_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(HomeScreenController()); // استخدام GetX Controller لإدارة الحالة
//
//     final List<Widget> _list = [
//       HomeOwnerScreen(),
//       SearchScreen(),
//       CreateNewProjectScreen(),
//       ProfileScreen(userId: '',),
//     ];
//
//     return Scaffold(
//       bottomNavigationBar: Obx(() {
//         return BottomNavigationBar(
//           currentIndex: controller.currentIndex.value, // استخدام GetX لإدارة currentIndex
//           onTap: (value) {
//             controller.changeTabIndex(value); // تغيير التبويب باستخدام GetX
//           },
//           backgroundColor: const Color(0xFF003366),
//           unselectedItemColor: Colors.white,
//           type: BottomNavigationBarType.fixed,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           items: [
//             BottomNavigationBarItem(
//               icon: _buildCustomIcon(Icons.home, 0, controller),
//               label: Trans('home').tr,
//             ),
//             BottomNavigationBarItem(
//               icon: _buildCustomIcon(Icons.search, 1, controller),
//               label: Trans('search').tr,
//             ),
//             BottomNavigationBarItem(
//               icon: _buildCustomIcon(Icons.add_circle_outline, 2, controller),
//               label: Trans('add').tr,
//             ),
//             BottomNavigationBarItem(
//               icon: _buildCustomIcon(Icons.person, 3, controller),
//               label: Trans('profile').tr,
//             ),
//           ],
//         );
//       }),
//       body: Obx(() {
//         return _list.elementAt(controller.currentIndex.value); // عرض الصفحة بناءً على currentIndex
//       }),
//     );
//   }
//
//   Widget _buildCustomIcon(IconData icon, int index, HomeScreenController controller) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: controller.currentIndex.value == index ? Colors.white : Colors.transparent,
//       ),
//       padding: const EdgeInsets.all(8),
//       child: Icon(
//         icon,
//         color: controller.currentIndex.value == index ? const Color(0xFF003366) : Colors.white,
//         size: 28,
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:takatuf/views/others/profile_screen.dart';
// import 'create_new_project_screen.dart';
// import 'home_owner_screen.dart';
// import '../others/search_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   final List<Widget> _list = [
//     HomeOwnerScreen(),
//     SearchScreen(),
//     CreateNewProjectScreen(),
//     // FavoritesScreen(),
//     ProfileScreen()
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (value) {
//           setState(() {
//             _currentIndex = value;
//           });
//         },
//         backgroundColor: const Color(0xFF003366),
//         unselectedItemColor: Colors.white,
//         type: BottomNavigationBarType.fixed,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: [
//           BottomNavigationBarItem(
//             icon: _buildCustomIcon(Icons.home, 0),
//             label: 'home'.tr(),
//           ),
//           BottomNavigationBarItem(
//             icon: _buildCustomIcon(Icons.search, 1),
//             label: 'search'.tr(),
//           ),
//           BottomNavigationBarItem(
//             icon: _buildCustomIcon(Icons.add_circle_outline, 2),
//             label: 'add'.tr(),
//           ),
//           // BottomNavigationBarItem(
//           //   icon: _buildCustomIcon(Icons.favorite_border, 3),
//           //   label: 'favorite'.tr(),
//           // ),
//           BottomNavigationBarItem(
//             icon: _buildCustomIcon(Icons.person, 4),
//             label: 'profile'.tr(),
//           ),
//         ],
//       ),
//       body: _list.elementAt(_currentIndex),
//     );
//   }
//
//   Widget _buildCustomIcon(IconData icon, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: _currentIndex == index ? Colors.white : Colors.transparent,
//       ),
//       padding: const EdgeInsets.all(8),
//       child: Icon(
//         icon,
//         color: _currentIndex == index ? const Color(0xFF003366) : Colors.white,
//         size: 28,
//       ),
//     );
//   }
// }
