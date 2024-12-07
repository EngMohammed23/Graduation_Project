import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatuf/views/login_screen.dart';

class WelcomeController extends GetxController {
  var currentPage = 0.obs;
  PageController pageController = PageController();

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void navigateToLogin() {
    // Navigate to the login or registration screen
    Get.to(() => LoginScreen());
  }
}
