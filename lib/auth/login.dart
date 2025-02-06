// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/auth/register.dart';
import 'package:machine_task/controllers/login_controller.dart';
import 'package:machine_task/utils/app_color_themes.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: ThemeConstants.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_outlined,
                      size: 48,
                      color: ThemeConstants.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Welcome Back',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: ThemeConstants.darkBlue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined, color: ThemeConstants.primaryBlue),
                      filled: true,
                      fillColor: ThemeConstants.lightBlue.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) =>
                        value != null && value.contains('@') ? null : 'Enter a valid email',
                  ),
                  const SizedBox(height: 16),
                  Obx(() => TextFormField(
                        controller: controller.passwordController,
                        obscureText: !controller.isPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline, color: ThemeConstants.primaryBlue),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: ThemeConstants.primaryBlue,
                            ),
                            onPressed: () {
                              controller.isPasswordVisible.toggle();
                            },
                          ),
                          filled: true,
                          fillColor: ThemeConstants.lightBlue.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value != null && value.length >= 6
                                ? null
                                : 'Password must be at least 6 characters',
                      )),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: ThemeConstants.primaryBlue,
                      ),
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeConstants.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      )),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextButton(
                        onPressed: () => Get.to(() =>   RegisterScreen()),
                        style: TextButton.styleFrom(
                          foregroundColor: ThemeConstants.primaryBlue,
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
