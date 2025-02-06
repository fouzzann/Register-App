import 'dart:io';
import 'package:flutter/material.dart';
import 'package:machine_task/utils/app_color_themes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Map<String, dynamic> user;

  const CustomAppBar({Key? key, required this.user}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ThemeConstants.backgroundColor,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: ThemeConstants.secondaryBlue,
            radius: 24,
            backgroundImage: user['profileImage'] != null
                ? Image.file(File(user['profileImage'])).image
                : null,
            child: user['profileImage'] == null
                ? Text(
                    user['name'][0].toUpperCase(),
                    style: const TextStyle(
                      color: ThemeConstants.backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
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
                user['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeConstants.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}