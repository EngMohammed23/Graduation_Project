import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // الإنجليزية
        Locale('ar', ''), // العربية
      ],
      locale: const Locale('ar', ''), // لتعيين العربية كافتراضية للتجربة
      debugShowCheckedModeBanner: false,
      home: FluidNavBarDemo(),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('مرحبا بك'), // "مرحبا بك" بالعربية
//       ),
//       backgroundColor: Color(0xFF75B7E1),
//       extendBody: true,
//       body: Center(
//         child: Text(
//             'هذا تطبيق يدعم اللغة العربية.'), // "هذا تطبيق يدعم اللغة العربية."
//       ),
//       bottomNavigationBar: FluidNavBar(                     // (1)
//           icons: [                                            // (2)
//             FluidNavBarIcon(svgPath: "assets/home.svg"),      // (3)
//             FluidNavBarIcon(svgPath: "assets/bookmark.svg"),
//           ],
//           onChange: _handleNavigationChange,                  // (4)
//         ),

//     );
//   }
// }
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرحبا بك'), // "مرحبا بك" بالعربية
      ),
      backgroundColor: Color(0xFF75B7E1),
      extendBody: true,
      body: Center(
        child: Text(
            'هذا تطبيق يدعم اللغة العربية.'), // "هذا تطبيق يدعم اللغة العربية."
      ),
    );
  }
}

class FluidNavBarDemo extends StatefulWidget {
  @override
  State createState() {
    return _FluidNavBarDemoState();
  }
}

class _FluidNavBarDemoState extends State {
  Widget? _child;

  @override
  void initState() {
    _child = HomePage();
    super.initState();
  }

  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF75B7E1),
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                svgPath: "assets/home.svg",
                backgroundColor: Color(0xFF4285F4),
                extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Icons.bookmark_border,
                backgroundColor: Color(0xFFEC4134),
                extras: {"label": "bookmark"}),
            FluidNavBarIcon(
                icon: Icons.apps,
                backgroundColor: Color(0xFFFCBA02),
                extras: {"label": "partner"}),
            FluidNavBarIcon(
                svgPath: "assets/conference.svg",
                backgroundColor: Color(0xFF34A950),
                extras: {"label": "conference"}),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white),
          scaleFactor: 1.5,
          defaultIndex: 1,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = HomePage();
          break;
        case 1:
          _child = HomePage();
          break;
        case 2:
          _child = HomePage();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
