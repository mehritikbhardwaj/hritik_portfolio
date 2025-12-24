import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/projects.dart';
import '../theme/app_theme.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  IconData _getProjectIcon(String category) {
    final lowerCategory = category.toLowerCase();
    if (lowerCategory.contains('fintech') ||
        lowerCategory.contains('finance')) {
      return Icons.account_balance_wallet_rounded;
    } else if (lowerCategory.contains('delivery') ||
        lowerCategory.contains('commerce')) {
      return Icons.shopping_bag_rounded;
    } else if (lowerCategory.contains('logistics') ||
        lowerCategory.contains('operations')) {
      return Icons.local_shipping_rounded;
    } else if (lowerCategory.contains('social') ||
        lowerCategory.contains('ai')) {
      return Icons.auto_awesome_rounded;
    } else if (lowerCategory.contains('real estate') ||
        lowerCategory.contains('analytics')) {
      return Icons.analytics_rounded;
    } else if (lowerCategory.contains('e-commerce') ||
        lowerCategory.contains('catalogue')) {
      return Icons.inventory_2_rounded;
    } else {
      return Icons.apps_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()
                ..scale(1.03)
                ..translate(0.0, -8.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryColor.withOpacity(0.4)
                : AppTheme.borderColor,
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? AppTheme.cardHoverShadow
              : AppTheme.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Project image with animated zoom on hover
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
              ),
              child: SizedBox(
                height: 160,
                width: double.infinity,
                child: Stack(
                  children: [
                    AnimatedScale(
                      scale: _isHovered ? 1.08 : 1.0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.primaryColor.withOpacity(0.15),
                              AppTheme.secondaryColor.withOpacity(0.15),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getProjectIcon(widget.project.category),
                                size: 48,
                                color: AppTheme.primaryColor.withOpacity(0.7),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.project.category.split('•').first.trim(),
                                style: TextStyle(
                                  color: AppTheme.primaryColor.withOpacity(0.7),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Gradient overlay
                    Positioned.fill(
                      child: AnimatedOpacity(
                        opacity: _isHovered ? 0.3 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryColor.withOpacity(0.4),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Project category badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.project.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Title
                  Text(
                    widget.project.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    widget.project.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Tech Stack
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.project.techStack.take(3).map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppTheme.borderColor),
                        ),
                        child: Text(
                          tech,
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  // Buttons only if URLs exist
                  if (widget.project.playStoreUrl != null ||
                      widget.project.appStoreUrl != null) ...[
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        if (widget.project.playStoreUrl != null)
                          Expanded(
                            child: _ProjectButton(
                              label: 'Play Store',
                              icon: Icons.android,
                              isPrimary: true,
                              onPressed: () =>
                                  _launchUrl(widget.project.playStoreUrl!),
                            ),
                          ),
                        if (widget.project.playStoreUrl != null &&
                            widget.project.appStoreUrl != null)
                          const SizedBox(width: 10),
                        if (widget.project.appStoreUrl != null)
                          Expanded(
                            child: _ProjectButton(
                              label: 'App Store',
                              icon: Icons.apple,
                              isPrimary: true,
                              onPressed: () =>
                                  _launchUrl(widget.project.appStoreUrl!),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Project Button (Top Level) ---

// --- Project Button (Top Level) ---

class _ProjectButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _ProjectButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<_ProjectButton> createState() => _ProjectButtonState();
}

class _ProjectButtonState extends State<_ProjectButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? AppTheme.primaryGradient : null,
            color: widget.isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: _isHovered
                        ? AppTheme.primaryColor
                        : AppTheme.borderColor,
                  ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: widget.isPrimary
                    ? Colors.white
                    : (_isHovered
                          ? AppTheme.primaryColor
                          : AppTheme.textSecondary),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isPrimary
                      ? Colors.white
                      : (_isHovered
                            ? AppTheme.primaryColor
                            : AppTheme.textSecondary),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
