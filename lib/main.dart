import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/views/screens/splash_sceen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,  
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}
