import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/db/db_helper.dart';
import 'package:machine_task/views/screens/home_screen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  void login() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 1));
      final user = await DatabaseHelper().getUser(
        emailController.text,
        passwordController.text,
      );

      if (user != null) {
        Get.off(() => HomeScreen(user: user));
      } else {
        showErrorSnackBar('Invalid email or password');
      }
    } catch (e) {
      showErrorSnackBar('An error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void showErrorSnackBar(String message) {
    Get.snackbar('Error', message,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8);
  }
}