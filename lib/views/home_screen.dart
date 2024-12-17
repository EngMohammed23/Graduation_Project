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
  final List<Widget> _list2 = [
    // Container(
    //   height: 37,
    //   width: 281,
    //   child: TextField(
    //       style: TextStyle(color: Colors.white),
    //       decoration: InputDecoration(
    //         hintText: 'Search album song ',
    //         hintStyle: TextStyle(
    //           color: Color(0XFF707070),
    //           fontSize: 13,
    //           fontWeight: FontWeight.normal,
    //         ),
    //         prefixIcon: Icon(Icons.search,color: Color(0XFF707070)),
    //         border: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(25),
    //             borderSide: BorderSide(color: Colors.grey.shade700)),
    //       )),
    // ),
    Text('Home'),
    Text('Search'),
    Text('AddScreen'),
    Text('FavoritesScreen'),
    Text('ProfileScreen'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: Column()),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // leading: ,
          title: _list2.elementAt(_currentIndex),
          centerTitle: true,
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite),
                )
              ],
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          backgroundColor: const Color(0XFF003366),
          unselectedItemColor: const Color(0XFF63666E),
          fixedColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_outline,
                ),
                label: 'Add'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border,
                ),
                label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Person'),
          ],
        ),
        body: _list.elementAt(_currentIndex));
  }
}
