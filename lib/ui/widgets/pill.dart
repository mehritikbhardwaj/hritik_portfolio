import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class Pill extends StatelessWidget {
  final String label;
  final bool isPrimary;

  const Pill({super.key, required this.label, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isPrimary
            ? AppTheme.primaryColor.withValues(alpha: 0.15)
            : AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPrimary
              ? AppTheme.primaryColor.withValues(alpha: 0.4)
              : AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isPrimary ? AppTheme.primaryColor : AppTheme.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
