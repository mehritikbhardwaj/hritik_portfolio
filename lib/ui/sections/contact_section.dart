import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';
import '../widgets/buttons.dart';

class ContactSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ContactSection({super.key, required this.sectionKey});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return SectionContainer(
      sectionKey: sectionKey,
      title: "Let's Work Together",
      subtitle: 'Have a project in mind? Let\'s create something amazing',
      backgroundColor: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          // Main CTA Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 36 : 56),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: AppTheme.borderColor),
              boxShadow: AppTheme.cardShadow,
            ),
            child: Column(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.35),
                        blurRadius: 28,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.mail_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 36),
                // Title
                Text(
                  'Ready to start your project?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                // Description
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: const Text(
                    "I'm always open to discussing new projects, creative ideas, or opportunities to be part of your visions. Drop me a message!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      height: 1.8,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // CTA Button
                GradientButton(
                  label: 'Send me an email',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () =>
                      _launchUrl('mailto:hritikbhardwaj41@gmail.com'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          // Contact Info Cards
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _ContactInfoCard(
                icon: Icons.email_rounded,
                label: 'Email',
                value: 'hritikbhardwaj41@gmail.com',
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C5CFF), Color(0xFF00D9FF)],
                ),
                onTap: () => _launchUrl('mailto:hritikbhardwaj41@gmail.com'),
              ),
              _ContactInfoCard(
                icon: Icons.phone_rounded,
                label: 'Phone',
                value: '+91 9212716009',
                gradient: const LinearGradient(
                  colors: [Color(0xFF00D9FF), Color(0xFF22C55E)],
                ),
                onTap: () => _launchUrl('tel:+919212716009'),
              ),
              _ContactInfoCard(
                icon: Icons.location_on_rounded,
                label: 'Location',
                value: 'India',
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B9D), Color(0xFFFF9F43)],
                ),
                onTap: null,
              ),
            ],
          ),
          const SizedBox(height: 48),
          // Social Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialLink(
                icon: Icons.code_rounded,
                label: 'GitHub',
                onTap: () => _launchUrl('https://github.com/mehritikbhardwaj/'),
              ),
              const SizedBox(width: 16),
              _SocialLink(
                icon: Icons.work_rounded,
                label: 'LinkedIn',
                onTap: () =>
                    _launchUrl('https://www.linkedin.com/in/hritikbhardwaj/'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactInfoCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final Gradient gradient;
  final VoidCallback? onTap;

  const _ContactInfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.gradient,
    this.onTap,
  });

  @override
  State<_ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<_ContactInfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: _isHovered && widget.onTap != null
              ? (Matrix4.identity()..translate(0.0, -6.0))
              : Matrix4.identity(),
          width: isMobile ? double.infinity : 280,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered && widget.onTap != null
                  ? AppTheme.primaryColor.withOpacity(0.4)
                  : AppTheme.borderColor,
              width: 1.5,
            ),
            boxShadow: _isHovered && widget.onTap != null
                ? AppTheme.cardHoverShadow
                : AppTheme.cardShadow,
          ),
          child: Column(
            children: [
              // Icon with gradient
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
                                .withOpacity(0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : [],
                ),
                child: Icon(widget.icon, color: Colors.white, size: 26),
              ),
              const SizedBox(height: 20),
              // Label
              Text(
                widget.label,
                style: const TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              // Value
              Text(
                widget.value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.surfaceColor : AppTheme.cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered ? AppTheme.primaryColor : AppTheme.borderColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: _isHovered
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondary,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered
                      ? AppTheme.primaryColor
                      : AppTheme.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
