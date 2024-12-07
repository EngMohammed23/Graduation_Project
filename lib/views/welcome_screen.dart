import 'package:damage_assessment_project/controller/welcome_controller.dart';
import 'package:damage_assessment_project/views/login_screen.dart';
import 'package:damage_assessment_project/views/pageview1.dart';
import 'package:damage_assessment_project/views/pageview2.dart';
import 'package:damage_assessment_project/views/pageview3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeController controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // "Skip" button
          Container(
            margin: EdgeInsets.fromLTRB(0, 40, 10, 0),
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.to(LoginScreen());
              },
              child: Text("Skip"),
            ),
          ),

          // PageView for sliding pages
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              children: [
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
                    margin: EdgeInsets.symmetric(horizontal: 4),
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

          // Conditionally render buttons under the indicator
          Obx(() {
            if (controller.currentPage.value == 0) {
              // Button for PageView1
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_rounded),
                ),
              );
            } else if (controller.currentPage.value == 1) {
              // Two buttons in a row for PageView2
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality for Button 1
                        print("Button 1 clicked on PageView2!");
                      },
                      child: Text("Button 1"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality for Button 2
                        print("Button 2 clicked on PageView2!");
                      },
                      child: Text("Button 2"),
                    ),
                  ],
                ),
              );
            } else if (controller.currentPage.value == 2) {
              // Single button for PageView3
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for the button
                    print("Button clicked on PageView3!");
                  },
                  child: Text("Pageview3 Button"),
                ),
              );
            }
            return SizedBox.shrink(); // Hide if no condition is met
          }),

          // Bottom padding to prevent content overflow
          Padding(
            padding: const EdgeInsets.all(20.0),
          ),
        ],
      ),
    );
  }
}
