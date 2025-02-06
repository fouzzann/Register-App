import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:machine_task/db/db_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Custom colors for blue theme (matching login screen)
  static const primaryBlue = Color(0xFF1A73E8);
  static const lightBlue = Color(0xFFE8F0FE);
  static const borderBlue = Color(0xFFBDDCFF);
  static const darkBlue = Color(0xFF1557B0);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  File? _profileImage;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[400],
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _register() async {
    if (!_formKey.currentState!.validate() || _profileImage == null) {
      _showErrorSnackBar('Please fill all fields and select a profile image');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await DatabaseHelper().insertUser( 
        _nameController.text,
        _emailController.text,
        _phoneController.text,
        _passwordController.text,
        _profileImage!.path,
      );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      _showErrorSnackBar('Email already exists!');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please fill in the form to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  // Profile Image Picker
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: borderBlue,
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: lightBlue,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : null,
                            child: _profileImage == null
                                ? Icon(
                                    Icons.person_outline,
                                    size: 50,
                                    color: primaryBlue,
                                  )
                                : null,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryBlue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 0,
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.add_a_photo_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                              onPressed: _pickImage,
                            ), 
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Form Fields
                  TextFormField(
                    controller: _nameController,
                    decoration: _getInputDecoration(
                      label: 'Full Name',
                      icon: Icons.person_outline,
                    ),
                    validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _getInputDecoration(
                      label: 'Email Address',
                      icon: Icons.email_outlined,
                    ),
                    validator: (value) =>
                      value != null && value.contains('@') ? null : 'Please enter a valid email',
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: _getInputDecoration(
                      label: 'Phone Number',
                      icon: Icons.phone_outlined,
                    ),
                    validator: (value) =>
                      value?.length == 10 ? null : 'Please enter a valid 10-digit phone number',
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: _getInputDecoration(
                      label: 'Password',
                      icon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                          color: primaryBlue,
                        ),
                        onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                      ),
                    ),
                    validator: (value) =>
                      value != null && value.length >= 6 ? null : 'Password must be at least 6 characters',
                  ),
                  const SizedBox(height: 32),
                  
                  // Register Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: primaryBlue,
                        ),
                        child: const Text(
                          'Sign In',
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}