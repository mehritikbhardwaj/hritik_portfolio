import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TestimonialsSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const TestimonialsSection({super.key, required this.sectionKey});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Testimonial> _testimonials = [
    Testimonial(
      name: 'Rahul Sharma',
      role: 'CTO, TechStartup Inc.',
      avatar: 'RS',
      content:
          'Hritik delivered exceptional work on our fintech app. His attention to detail and understanding of complex business requirements was impressive. The app exceeded our expectations!',
      rating: 5,
    ),
    Testimonial(
      name: 'Priya Mehta',
      role: 'Founder, HelloDish',
      avatar: 'PM',
      content:
          'Working with Hritik was a seamless experience. He built our food delivery platform from scratch with real-time tracking and payment integration. Highly recommended!',
      rating: 5,
    ),
    Testimonial(
      name: 'Amit Patel',
      role: 'Product Manager, EFL',
      avatar: 'AP',
      content:
          'Hritik\'s expertise in Flutter helped us launch our enterprise app in record time. His code quality and architecture decisions have made the app very maintainable.',
      rating: 5,
    ),
    Testimonial(
      name: 'Sarah Johnson',
      role: 'Director, Landable',
      avatar: 'SJ',
      content:
          'The analytics dashboard Hritik built for us transformed how we present data to clients. Beautiful UI, smooth animations, and excellent performance.',
      rating: 5,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85, initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      key: widget.sectionKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 16 : 24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.03),
            AppTheme.secondaryColor.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Section Header
          _buildSectionHeader(context, isMobile),
          SizedBox(height: isMobile ? 40 : 60),
          // Testimonial Cards
          SizedBox(
            height: isMobile ? 320 : 280,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _testimonials.length,
              itemBuilder: (context, index) {
                return AnimatedScale(
                  scale: _currentIndex == index ? 1.0 : 0.9,
                  duration: const Duration(milliseconds: 300),
                  child: _TestimonialCard(
                    testimonial: _testimonials[index],
                    isActive: _currentIndex == index,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          // Pagination Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _testimonials.length,
              (index) => GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 32 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: _currentIndex == index
                        ? AppTheme.primaryGradient
                        : null,
                    color: _currentIndex == index ? null : AppTheme.borderColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isMobile) {
    return Column(
      children: [
        // Section badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.format_quote_rounded, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text(
                'TESTIMONIALS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Section title
        Text(
          'What Clients Say',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
            fontSize: isMobile ? 28 : 40,
          ),
        ),
        const SizedBox(height: 16),
        // Section description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'Trusted by startups and enterprises to deliver quality apps',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class Testimonial {
  final String name;
  final String role;
  final String avatar;
  final String content;
  final int rating;

  const Testimonial({
    required this.name,
    required this.role,
    required this.avatar,
    required this.content,
    required this.rating,
  });
}

class _TestimonialCard extends StatefulWidget {
  final Testimonial testimonial;
  final bool isActive;

  const _TestimonialCard({required this.testimonial, required this.isActive});

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<_TestimonialCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: widget.isActive
                ? AppTheme.primaryColor.withOpacity(0.3)
                : AppTheme.borderColor,
          ),
          boxShadow: _isHovered || widget.isActive
              ? AppTheme.cardHoverShadow
              : AppTheme.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote icon
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: const Icon(
                Icons.format_quote_rounded,
                size: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            // Content
            Expanded(
              child: Text(
                widget.testimonial.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.7,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 20),
            // Rating stars
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < widget.testimonial.rating
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: Colors.amber,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Author info
            Row(
              children: [
                // Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      widget.testimonial.avatar,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Name and role
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.testimonial.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.testimonial.role,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
