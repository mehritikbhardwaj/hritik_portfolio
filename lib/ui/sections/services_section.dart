import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';

class ServicesSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ServicesSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return SectionContainer(
      sectionKey: sectionKey,
      title: 'Services',
      subtitle: 'What I can do for you',
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth < 600
              ? 1
              : (constraints.maxWidth < 900 ? 2 : 3);

          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: isMobile ? 1.4 : 1.1,
            children: const [
              _ServiceCard(
                icon: Icons.phone_android_rounded,
                title: 'Mobile App Development',
                description:
                    'Native-quality iOS & Android apps built with Flutter for seamless cross-platform experiences.',
                gradient: LinearGradient(
                  colors: [Color(0xFF7C5CFF), Color(0xFF00D9FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              _ServiceCard(
                icon: Icons.web_rounded,
                title: 'Web App Development',
                description:
                    'Responsive Flutter web applications with modern UI/UX that work flawlessly across all browsers.',
                gradient: LinearGradient(
                  colors: [Color(0xFF00D9FF), Color(0xFF22C55E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              _ServiceCard(
                icon: Icons.design_services_rounded,
                title: 'UI/UX Design',
                description:
                    'Beautiful, intuitive interfaces designed with user experience at the core of every decision.',
                gradient: LinearGradient(
                  colors: [Color(0xFFFF6B9D), Color(0xFFFF9F43)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              _ServiceCard(
                icon: Icons.api_rounded,
                title: 'API Integration',
                description:
                    'Seamless REST & GraphQL integrations with robust error handling and offline support.',
                gradient: LinearGradient(
                  colors: [Color(0xFF22C55E), Color(0xFF7C5CFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              _ServiceCard(
                icon: Icons.cloud_rounded,
                title: 'Firebase & Backend',
                description:
                    'Complete backend solutions with Firebase, authentication, real-time databases, and cloud functions.',
                gradient: LinearGradient(
                  colors: [Color(0xFFFF9F43), Color(0xFFFF6B9D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              _ServiceCard(
                icon: Icons.speed_rounded,
                title: 'Performance Optimization',
                description:
                    'App auditing and optimization for faster load times, smooth animations, and better UX.',
                gradient: LinearGradient(
                  colors: [Color(0xFF00D9FF), Color(0xFF7C5CFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Gradient gradient;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0.0, -8.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(28),
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
          children: [
            // Icon with gradient background
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: (widget.gradient as LinearGradient)
                              .colors
                              .first
                              .withOpacity(0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : [],
              ),
              child: Icon(widget.icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            // Description
            Expanded(
              child: Text(
                widget.description,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  height: 1.7,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
