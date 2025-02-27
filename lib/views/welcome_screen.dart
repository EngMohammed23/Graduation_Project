import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:takatuf/views/signin_screen.dart';
import 'package:takatuf/views/splash/pageview1.dart';
import 'package:takatuf/views/splash/pageview2.dart';
import 'package:takatuf/views/splash/pageview3.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skipToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SigninScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // "Skip" button
          Container(
            margin: const EdgeInsets.fromLTRB(0, 40, 10, 0),
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _skipToSignIn,
              child: Text(
                "skip".tr(),
                style: TextStyle(color: Color(0xFF003366)),
              ),
            ),
          ),

          // PageView for sliding pages
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: const [
                Pageview1(),
                Pageview2(),
                Pageview3(),
              ],
            ),
          ),

          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),

          // Navigation Buttons
          if (_currentPage == 0) ...[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 30.0, top: 16.0),
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF003366),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: _goToNextPage,
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ] else if (_currentPage == 1) ...[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFBCE0FD),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _goToPreviousPage,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF003366),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _goToNextPage,
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (_currentPage == 2) ...[
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF003366),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: TextButton(
                  onPressed: _skipToSignIn,
                  child: Text(
                    "getStarted".tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],

          Padding(
            padding: const EdgeInsets.all(70.0),
          ),
        ],
      ),
    );
  }
}
