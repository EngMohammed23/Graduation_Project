import 'package:flutter/material.dart';
import 'package:takatuf/views/profile_screen.dart';
import 'Home.dart';
import 'add_screen.dart';
import 'favorites_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _list = [
    Home(),
    SearchScreen(),
    AddScreen(),
    FavoritesScreen(),
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
          backgroundColor: const Color(0xFF003366), // لون الخلفية
          unselectedItemColor: Colors.white, // لون العناصر غير المختارة
          type: BottomNavigationBarType.fixed, // تثبيت العناصر
          showSelectedLabels: false, // إخفاء النص النشط
          showUnselectedLabels: false, // إخفاء النصوص غير النشطة
          items: [
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.home, 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.search, 1),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.add_circle_outline, 2),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.favorite_border, 3),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.person, 4),
              label: 'Person',
            ),
          ],
        ),
        body: _list.elementAt(_currentIndex));
  }
  Widget _buildCustomIcon(IconData icon, int index) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.white : Colors.transparent,
      ),
      padding: const EdgeInsets.all(8), // حجم الدائرة حول الأيقونة
      child: Icon(
        icon,
        color: _currentIndex == index ? const Color(0xFF729F3A) : Colors.white,
        size: 28, // حجم الأيقونة
      ),
    );
  }

}
