import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/auth/login.dart';
import 'package:machine_task/views/screens/api_page.dart';
import 'package:machine_task/views/screens/user_list.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      UserListScreen(currentUser: widget.user),
      ApiScreen(), 
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Welcome, ${widget.user['name']}!')),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            _logout(context);
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.api), label: 'API'),
          BottomNavigationBarItem(icon: Icon(Icons.logout_outlined), label: 'Logout'),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Get.to(() => const LoginScreen()), child: const Text('Logout')),
        ],
      ),
    );
  }
}





