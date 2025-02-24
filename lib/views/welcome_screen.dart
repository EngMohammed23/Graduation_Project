import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatuf/controller/welcome_controller.dart';
import 'package:takatuf/views/Signin_screen.dart';
import 'package:takatuf/views/splash/pageview1.dart';
import 'package:takatuf/views/splash/pageview2.dart';
import 'package:takatuf/views/splash/pageview3.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeController controller = Get.put(WelcomeController());

  WelcomeScreen({super.key});

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
              onPressed: () {
                Get.offAll(SigninScreen());

              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Color(0xFF003366)),
              ),
            ),
          ),

          // PageView for sliding pages
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              children: const [
                Pageview1(),
                Pageview2(),
                Pageview3(),
              ],
            ),
          ),

          // Page indicators
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: controller.currentPage.value == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              )),

          // Navigation Buttons
          Obx(() {
            if (controller.currentPage.value == 0) {
              // Button for PageView1 (Forward Only)
              return Align(
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
                    onPressed: () {
                      controller.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else if (controller.currentPage.value == 1) {
              // Two buttons for PageView2 (Back & Forward)
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Back Button
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFFBCE0FD),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Forward Button
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFF003366),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (controller.currentPage.value == 2) {
              // Single button for PageView3
              return Container(
                padding: const EdgeInsets.only(top: 16.0),
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFF003366),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: TextButton(
                    onPressed: () {
                      Get.offAll(SigninScreen());
                    },
                    child: Text(
                      "Get started",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }
            return SizedBox.shrink(); // Hide if no condition is met
          }),

          // Bottom padding to prevent content overflow
          Padding(
            padding: const EdgeInsets.all(70.0),
          ),
        ],
      ),
    );
  }
}
