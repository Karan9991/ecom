import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  bool isLastPage(int totalPages) {
    return currentPage.value == totalPages - 1;
  }

  void nextPage(PageController pageController) {
    pageController.nextPage(
      duration:const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
