import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/auth/login.dart';
import 'package:machine_task/views/screens/home_screen.dart';
import 'package:machine_task/db/db_helper.dart';
import 'package:machine_task/utils/app_color_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
    
    // Check authentication state and navigate accordingly
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Delay for splash screen animation
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('user_email');
    final savedPassword = prefs.getString('user_password');

    if (savedEmail != null && savedPassword != null) {
      try {
        // Attempt to get user with saved credentials
        final user = await DatabaseHelper().getUser(savedEmail, savedPassword);
        
        if (user != null) {
          // Valid credentials, navigate to home
          Get.offAll(() => HomeScreen(user: user));
          return;
        }
      } catch (e) {
        // Handle any database errors
        print('Error checking saved credentials: $e');
      }
    }

    // No valid saved credentials, go to login
    Get.offAll(() => const LoginScreen());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'assets/Machine task app log.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              'Register App',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ), 
            ),
            
            const SizedBox(height: 32),
            
            CircularProgressIndicator(
              color: AppColor.progressIndcatorColor,
            )
          ],
        ),
      ),
    );
  }
}