import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:takatuf/views/others/profile_screen.dart';
import 'create_new_project_screen.dart';
import 'home_owner_screen.dart';
import '../others/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _list = [
    HomeOwnerScreen(),
    SearchScreen(),
    CreateNewProjectScreen(),
    // FavoritesScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        backgroundColor: const Color(0xFF003366),
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: _buildCustomIcon(Icons.home, 0),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildCustomIcon(Icons.search, 1),
            label: 'search'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildCustomIcon(Icons.add_circle_outline, 2),
            label: 'add'.tr(),
          ),
          // BottomNavigationBarItem(
          //   icon: _buildCustomIcon(Icons.favorite_border, 3),
          //   label: 'favorite'.tr(),
          // ),
          BottomNavigationBarItem(
            icon: _buildCustomIcon(Icons.person, 4),
            label: 'profile'.tr(),
          ),
        ],
      ),
      body: _list.elementAt(_currentIndex),
    );
  }

  Widget _buildCustomIcon(IconData icon, int index) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.white : Colors.transparent,
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        color: _currentIndex == index ? const Color(0xFF003366) : Colors.white,
        size: 28,
      ),
    );
  }
}
