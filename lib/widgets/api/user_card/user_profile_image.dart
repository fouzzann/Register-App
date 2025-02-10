import 'package:flutter/material.dart';
import 'package:machine_task/models/api_model.dart';
import 'package:machine_task/utils/app_color_themes.dart';

class UserProfileImage extends StatelessWidget {
  final User user;

  const UserProfileImage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile_${user.id}',
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ThemeConstants.primaryBlue.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: ThemeConstants.primaryBlue.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            user.profileImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.person,
              size: 30,
              color: ThemeConstants.primaryBlue.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}