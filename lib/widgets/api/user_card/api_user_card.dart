import 'package:flutter/material.dart';
import 'package:machine_task/models/api_model.dart';
import 'package:machine_task/utils/app_color_themes.dart';
import 'package:machine_task/widgets/api/user_card/user_info_section.dart';
import 'package:machine_task/widgets/api/user_card/user_profile_image.dart';

class UserCard extends StatefulWidget {
  final User user;
  final VoidCallback? onTap;

  const UserCard({
    Key? key,
    required this.user,
    this.onTap,
  }) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: _buildCardDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  UserProfileImage(
                    user: widget.user,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: UserInfoSection(user: widget.user), 
                  ),
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    isHovered ? _controller.forward() : _controller.reverse();
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: ThemeConstants.backgroundColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: _isHovered 
            ? ThemeConstants.primaryBlue.withOpacity(0.3) 
            : Colors.grey.withOpacity(0.1),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: ThemeConstants.primaryBlue.withOpacity(_isHovered ? 0.1 : 0.05),
          blurRadius: _isHovered ? 15 : 10,
          offset: const Offset(0, 5),
          spreadRadius: _isHovered ? 2 : 0,
        ),
      ],
    );
  }
}