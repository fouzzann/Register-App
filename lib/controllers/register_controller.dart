import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_task/db/db_helper.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  var profileImage = Rx<File?>(null);
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  void showErrorSnackBar(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void register() async {
    if (!formKey.currentState!.validate() || profileImage.value == null) {
      showErrorSnackBar('Please fill all fields and select a profile image');
      return;
    }

    isLoading.value = true;
    try {
      await DatabaseHelper().insertUser(
        nameController.text,
        emailController.text,
        phoneController.text,
        passwordController.text,
        profileImage.value!.path,
      );
      Get.back();
    } catch (e) {
      showErrorSnackBar('Email already exists!');
    } finally {
      isLoading.value = false;
    }
  }
}