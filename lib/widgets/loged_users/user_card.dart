import 'dart:io';

import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          if (user['profileImage'] != null) ...[
            const SizedBox(height: 16),
            Center(
              child: ClipOval(
                child: Image.file(
                  File(user['profileImage']),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey[200],
                      child: const Icon(Icons.person, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ],
          ListTile(
            title: Text(
              user['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(children: [
                  const Icon(Icons.email_outlined, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(user['email'], style: TextStyle(color: Colors.grey[600])),
                  ),
                ]),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.phone_outlined, size: 16),
                  const SizedBox(width: 8),
                  Text(user['phone'] ?? 'No phone number', style: TextStyle(color: Colors.grey[600])),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
