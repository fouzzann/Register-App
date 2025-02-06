import 'package:flutter/material.dart';
import 'package:machine_task/utils/app_color_themes.dart';
import 'package:machine_task/views/screens/api_page.dart';
import 'package:machine_task/views/screens/user_list.dart';
import 'package:machine_task/widgets/loged_users/app_bar_contant.dart';
import 'package:machine_task/widgets/loged_users/bottom_nav_bar.dart';
import 'package:machine_task/widgets/loged_users/logout_dialog.dart';


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
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeConstants.backgroundColor,
        title: AppBarContent(user: widget.user),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onDestinationSelected: _onNavDestinationSelected,
      ),
    );
  }

  void _onNavDestinationSelected(int index) {
    if (index == 2) {
      _logout(context);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _logout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => LogoutDialog(),
    );
  }
}
