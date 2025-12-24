import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionContainer extends StatelessWidget {
  final GlobalKey sectionKey;
  final String? title;
  final String? subtitle;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final bool centerTitle;

  const SectionContainer({
    super.key,
    required this.sectionKey,
    this.title,
    this.subtitle,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
    this.backgroundColor,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      decoration: BoxDecoration(color: backgroundColor ?? Colors.transparent),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: centerTitle
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        AppTheme.primaryGradient.createShader(bounds),
                    child: Text(
                      title!,
                      textAlign: centerTitle
                          ? TextAlign.center
                          : TextAlign.start,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      subtitle!,
                      textAlign: centerTitle
                          ? TextAlign.center
                          : TextAlign.start,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                  const SizedBox(height: 60),
                ],
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
