import 'dart:io';

import 'package:flutter/material.dart';
import 'package:machine_task/utils/app_color_themes.dart';

class UserProfileAvatar extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserProfileAvatar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
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
    );
  }
}