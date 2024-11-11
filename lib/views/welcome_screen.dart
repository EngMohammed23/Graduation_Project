import 'package:damage_assessment_project/controller/welcome_controller.dart';
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
          Padding(
            padding: const EdgeInsets.all(120.0),
          ),
        ],
      ),
    );
  }
}
