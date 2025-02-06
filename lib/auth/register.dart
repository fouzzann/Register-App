import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:machine_task/controllers/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final controller = Get.put(RegisterController());

  static const primaryBlue = Color(0xFF1A73E8);
  static const lightBlue = Color(0xFFE8F0FE);
  static const borderBlue = Color(0xFFBDDCFF);
  static const darkBlue = Color(0xFF1557B0);

  InputDecoration _getInputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[600]),
      prefixIcon: Icon(icon, color: primaryBlue),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: lightBlue.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderBlue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryBlue, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Text('Create Account',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: darkBlue),
                    textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text('Please fill in the form to continue',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center),
                const SizedBox(height: 32),
                Center(
                  child: Stack(
                    children: [
                      Obx(() => CircleAvatar(
                            radius: 50,
                            backgroundColor: lightBlue,
                            backgroundImage: controller.profileImage.value != null
                                ? FileImage(controller.profileImage.value!)
                                : null,
                            child: controller.profileImage.value == null
                                ? Icon(Icons.person_outline, size: 50, color: primaryBlue)
                                : null,
                          )),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.add_a_photo_rounded, size: 18, color: Colors.white),
                          onPressed: controller.pickImage,
                          color: primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: controller.nameController,
                  decoration: _getInputDecoration(label: 'Full Name', icon: Icons.person_outline),
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _getInputDecoration(label: 'Email Address', icon: Icons.email_outlined),
                  validator: (value) => value != null && value.contains('@') ? null : 'Please enter a valid email',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: _getInputDecoration(label: 'Phone Number', icon: Icons.phone_outlined),
                  validator: (value) => value?.length == 10 ? null : 'Please enter a valid 10-digit phone number',
                ),
                const SizedBox(height: 16),
                Obx(() => TextFormField(
                      controller: controller.passwordController,
                      obscureText: !controller.isPasswordVisible.value,
                      decoration: _getInputDecoration(
                        label: 'Password',
                        icon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(controller.isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                              color: primaryBlue),
                          onPressed: () => controller.isPasswordVisible.toggle(),
                        ),
                      ),
                      validator: (value) => value != null && value.length >= 6
                          ? null
                          : 'Password must be at least 6 characters',
                    )),
                const SizedBox(height: 32),
                Obx(() => ElevatedButton(
                      onPressed: controller.isLoading.value ? null : controller.register,
                      child: controller.isLoading.value
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    )),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
