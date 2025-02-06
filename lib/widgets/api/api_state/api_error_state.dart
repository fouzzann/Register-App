import 'package:flutter/material.dart';
import 'package:machine_task/utils/app_color_themes.dart';

class ApiErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const ApiErrorState({Key? key, required this.error, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, size: 32, color: Colors.red[400]),
            ),
            const SizedBox(height: 16),
            Text(
              error,
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeConstants.primaryBlue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh_rounded, color: ThemeConstants.backgroundColor),
              label: Text(
                'Try Again',
                style: TextStyle(color: ThemeConstants.backgroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
