import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../theme/app_theme.dart';
import '../widgets/buttons.dart';

class HeroSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final VoidCallback onViewProjectsTap;
  final VoidCallback onHireMeTap;

  const HeroSection({
    super.key,
    required this.sectionKey,
    required this.onViewProjectsTap,
    required this.onHireMeTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _downloadResume() {
    _launchUrl('assets/resume.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      key: widget.sectionKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar with animated border
                  const _AnimatedAvatar(),
                  const SizedBox(height: 32),
                  // Status badge with pulse animation
                  _AnimatedBadge(),
                  const SizedBox(height: 40),
                  // Main headline
                  Text(
                    "I'm Hritik Bhardwaj",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                      fontSize: isMobile ? 40 : 68,
                      height: 1.1,
                      letterSpacing: -2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Role with typing animation
                  SizedBox(
                    height: isMobile ? 36 : 48,
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 24 : 36,
                          ),
                      child: ShaderMask(
                        shaderCallback: (bounds) =>
                            AppTheme.primaryGradient.createShader(bounds),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: const Duration(milliseconds: 1500),
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Freelance Flutter Developer',
                              speed: const Duration(milliseconds: 80),
                            ),
                            TypewriterAnimatedText(
                              'Mobile App Developer',
                              speed: const Duration(milliseconds: 80),
                            ),
                            TypewriterAnimatedText(
                              'Full-Stack App Engineer',
                              speed: const Duration(milliseconds: 80),
                            ),
                            TypewriterAnimatedText(
                              'UI/UX Enthusiast',
                              speed: const Duration(milliseconds: 80),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Description
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 650),
                    child: Text(
                      'I craft exceptional mobile & web experiences with Flutter. '
                      'From stunning UI designs to robust app architecture — '
                      'I bring your ideas to life with clean code and pixel-perfect precision.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textSecondary,
                        height: 1.8,
                        fontSize: isMobile ? 16 : 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  // CTA Buttons
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      GradientButton(
                        label: 'Hire Me',
                        icon: Icons.rocket_launch_rounded,
                        onPressed: widget.onHireMeTap,
                      ),
                      SecondaryButton(
                        label: 'View My Work',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: widget.onViewProjectsTap,
                      ),
                      SecondaryButton(
                        label: 'Resume',
                        icon: Icons.download_rounded,
                        onPressed: _downloadResume,
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  // Social Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialButton(
                        icon: Icons.code_rounded,
                        label: 'GitHub',
                        onPressed: () =>
                            _launchUrl('https://github.com/mehritikbhardwaj/'),
                      ),
                      const SizedBox(width: 16),
                      _SocialButton(
                        icon: Icons.work_rounded,
                        label: 'LinkedIn',
                        onPressed: () => _launchUrl(
                          'https://www.linkedin.com/in/hritikbhardwaj/',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  // Stats
                  _AnimatedStatsCard(isMobile: isMobile),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedBadge extends StatefulWidget {
  @override
  State<_AnimatedBadge> createState() => _AnimatedBadgeState();
}

class _AnimatedBadgeState extends State<_AnimatedBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFF22C55E,
                      ).withOpacity(0.3 + (_pulseController.value * 0.4)),
                      blurRadius: 8 + (_pulseController.value * 4),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          const Text(
            'Available for freelance projects',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedStatsCard extends StatefulWidget {
  final bool isMobile;

  const _AnimatedStatsCard({required this.isMobile});

  @override
  State<_AnimatedStatsCard> createState() => _AnimatedStatsCardState();
}

class _AnimatedStatsCardState extends State<_AnimatedStatsCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0.0, -4.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryColor.withOpacity(0.3)
                : AppTheme.borderColor,
          ),
          boxShadow: _isHovered
              ? AppTheme.cardHoverShadow
              : AppTheme.cardShadow,
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: widget.isMobile ? 40 : 80,
          runSpacing: 32,
          children: [
            _AnimatedStatCounter(
              target: 4,
              suffix: '+',
              label: 'Years Experience',
              duration: 1200,
            ),
            _AnimatedStatCounter(
              target: 50,
              suffix: '+',
              label: 'Projects Delivered',
              duration: 1200,
            ),
            _AnimatedStatCounter(
              target: 30,
              suffix: '+',
              label: 'Happy Clients',
              duration: 1200,
            ),
            _AnimatedStatCounter(
              target: 100,
              suffix: '%',
              label: 'Client Satisfaction',
              duration: 1200,
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedStatCounter extends StatelessWidget {
  final int target;
  final String suffix;
  final String label;
  final int duration;

  const _AnimatedStatCounter({
    required this.target,
    required this.suffix,
    required this.label,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: target.toDouble()),
      duration: Duration(milliseconds: duration),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                '${value.round()}$suffix',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
          transform: _isHovered
              ? (Matrix4.identity()..scale(1.05))
              : Matrix4.identity(),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.glassColor : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered ? AppTheme.primaryColor : AppTheme.borderColor,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
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
                      : AppTheme.textSecondary,
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

class _StatItem extends StatefulWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  State<_StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<_StatItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.1))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                widget.value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedAvatar extends StatefulWidget {
  const _AnimatedAvatar();

  @override
  State<_AnimatedAvatar> createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<_AnimatedAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _borderController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _borderController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _borderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.05))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated rotating gradient border
            AnimatedBuilder(
              animation: _borderController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _borderController.value * 2 * 3.14159,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          AppTheme.primaryColor,
                          AppTheme.secondaryColor,
                          AppTheme.accentPink,
                          AppTheme.primaryColor,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // Inner white circle
            Container(
              width: 132,
              height: 132,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            // Avatar content with initials
            Container(
              width: 124,
              height: 124,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.1),
                    AppTheme.secondaryColor.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.primaryGradient.createShader(bounds),
                  child: const Text(
                    'HB',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // Glow effect on hover
            if (_isHovered)
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
