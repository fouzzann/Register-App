import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/auth/login.dart';
import 'package:machine_task/views/screens/api_page.dart';
import 'package:machine_task/views/screens/user_list.dart';

// Define theme colors
const primaryBlue = Color(0xFF2196F3);
const secondaryBlue = Color(0xFF64B5F6);
const backgroundColor = Colors.white;

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final List<Widget> _pages;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pages = [
      UserListScreen(currentUser: widget.user),
      ApiScreen(),
    ];

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
  appBar: AppBar(
  elevation: 0,
  backgroundColor: backgroundColor,
  title: Row(
    children: [
      CircleAvatar(
        backgroundColor: secondaryBlue,
        radius: 24,  
        backgroundImage: widget.user['profileImage'] != null 
            ? Image.file(File(widget.user['profileImage'])).image 
            : null,  
        child: widget.user['profileImage'] == null
            ? Text(
                widget.user['name'][0].toUpperCase(),  
                style: const TextStyle(
                  color: backgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null, // Display the first letter if no profile image is available
      ),
      const SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back,',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            widget.user['name'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    ],
  ),
),

      body: FadeTransition(
        opacity: _fadeAnimation,
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          backgroundColor: backgroundColor,
          indicatorColor: secondaryBlue,
          onDestinationSelected: (index) {
            if (index == 2) {
              _logout(context);
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.people_outline, color: primaryBlue),
              selectedIcon: Icon(Icons.people, color: backgroundColor),
              label: 'Users',
            ),
            NavigationDestination(
              icon: Icon(Icons.api_outlined, color: primaryBlue),
              selectedIcon: Icon(Icons.api, color: backgroundColor),
              label: 'API',
            ),
            NavigationDestination(
              icon: Icon(Icons.logout_outlined, color: primaryBlue),
              label: 'Logout',
              
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Icon(
              Icons.logout_rounded,
              size: 40,
              color: primaryBlue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(color: primaryBlue),
                      ),
                      child: const Text('Cancel', style: TextStyle(color: primaryBlue)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.offAll(() => LoginScreen()),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Logout', style: TextStyle(color: backgroundColor)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}