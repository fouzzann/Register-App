// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/widgets/loged_users/logout_dialog.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  final Map<String, dynamic> user;
  HomeController(this.user);

  RxInt currentIndex = 0.obs;
  late final AnimationController _animationController;
  late final Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void logout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => LogoutModalWidget(),
    );
  }
}
