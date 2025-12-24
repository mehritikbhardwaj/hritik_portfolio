import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'ui/theme/app_theme.dart';
import 'ui/theme/theme_provider.dart';
import 'ui/widgets/nav_bar.dart';
import 'ui/sections/hero_section.dart';
import 'ui/sections/about_section.dart';
import 'ui/sections/projects_section.dart';
import 'ui/sections/contact_section.dart';
import 'ui/sections/services_section.dart';
import 'ui/sections/testimonials_section.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Hritik Bhardwaj | Freelance Flutter Developer',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const PortfolioPage(),
        );
      },
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  // Section keys for smooth scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background orbs (fixed position)
          Positioned.fill(child: _BackgroundDecoration()),
          // Main Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Add padding for fixed navbar
                const SizedBox(height: 80),
                // Hero Section
                HeroSection(
                  sectionKey: _heroKey,
                  onViewProjectsTap: () => _scrollToSection(_projectsKey),
                  onHireMeTap: () => _scrollToSection(_contactKey),
                ),
                // About Section
                AboutSection(sectionKey: _aboutKey),
                // Services Section
                ServicesSection(sectionKey: _servicesKey),
                // Projects Section
                ProjectsSection(sectionKey: _projectsKey),
                // Testimonials Section
                TestimonialsSection(sectionKey: _testimonialsKey),
                // Contact Section
                ContactSection(sectionKey: _contactKey),
                // Footer
                const _Footer(),
              ],
            ),
          ),
          // Fixed Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              onHomeTap: () => _scrollToSection(_heroKey),
              onAboutTap: () => _scrollToSection(_aboutKey),
              onServicesTap: () => _scrollToSection(_servicesKey),
              onProjectsTap: () => _scrollToSection(_projectsKey),
              onContactTap: () => _scrollToSection(_contactKey),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundDecoration extends StatefulWidget {
  const _BackgroundDecoration();

  @override
  State<_BackgroundDecoration> createState() => _BackgroundDecorationState();
}

class _BackgroundDecorationState extends State<_BackgroundDecoration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // Gradient mesh background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        const Color(0xFF0F0F1A),
                        const Color(0xFF1A1A2E),
                        const Color(0xFF16213E),
                      ]
                    : [
                        const Color(0xFFFAFAFC),
                        const Color(0xFFF3F4F6),
                        const Color(0xFFEDE9FE),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Animated floating orbs
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  // Indigo orb top right with slow float
                  Positioned(
                    top: -200 + (50 * _sin(_controller.value * 2)),
                    right: -200 + (30 * _cos(_controller.value)),
                    child: _GradientOrb(
                      size: 600,
                      colors: [
                        AppTheme.primaryColor.withOpacity(isDark ? 0.15 : 0.12),
                        AppTheme.primaryColor.withOpacity(isDark ? 0.05 : 0.04),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  // Cyan orb bottom left
                  Positioned(
                    bottom: -100 + (40 * _cos(_controller.value * 1.5)),
                    left: -200 + (60 * _sin(_controller.value * 0.8)),
                    child: _GradientOrb(
                      size: 500,
                      colors: [
                        AppTheme.secondaryColor.withOpacity(
                          isDark ? 0.12 : 0.10,
                        ),
                        AppTheme.secondaryColor.withOpacity(
                          isDark ? 0.04 : 0.03,
                        ),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  // Pink accent orb
                  Positioned(
                    top: 400 + (70 * _sin(_controller.value * 1.2)),
                    left: -100 + (40 * _cos(_controller.value * 0.6)),
                    child: _GradientOrb(
                      size: 300,
                      colors: [
                        AppTheme.accentPink.withOpacity(isDark ? 0.10 : 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  // Additional emerald orb for depth
                  Positioned(
                    top: 800 + (50 * _cos(_controller.value)),
                    right: -50 + (30 * _sin(_controller.value * 1.4)),
                    child: _GradientOrb(
                      size: 250,
                      colors: [
                        AppTheme.accentGreen.withOpacity(isDark ? 0.10 : 0.06),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  // Floating particles
                  ...List.generate(6, (index) {
                    final offset = index * 0.15;
                    return Positioned(
                      top:
                          (index * 300.0) +
                          (30 * _sin(_controller.value * 2 + offset)),
                      left:
                          ((index % 3) * 400.0) +
                          (40 * _cos(_controller.value + offset)),
                      child: _FloatingParticle(
                        size: 8.0 + (index * 2),
                        opacity:
                            0.15 + (0.1 * _sin(_controller.value * 3 + offset)),
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  double _sin(double value) => math.sin(value * math.pi * 2);
  double _cos(double value) => math.cos(value * math.pi * 2);
}

class _GradientOrb extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const _GradientOrb({required this.size, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: colors),
      ),
    );
  }
}

class _FloatingParticle extends StatelessWidget {
  final double size;
  final double opacity;

  const _FloatingParticle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(opacity),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: AppTheme.borderColor, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            // Gradient text logo
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                'HB',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '© ${DateTime.now().year} Hritik Bhardwaj. Crafted with Flutter ❤️',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
