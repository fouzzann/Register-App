import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/auth/login.dart';
import 'package:machine_task/utils/app_color_themes.dart';

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

    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => LoginScreen());
    });
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