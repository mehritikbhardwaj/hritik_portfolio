import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';

class AboutSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const AboutSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return SectionContainer(
      sectionKey: sectionKey,
      title: 'About Me',
      subtitle: 'Get to know me better',
      backgroundColor: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          // About content
          Container(
            padding: EdgeInsets.all(isMobile ? 28 : 48),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppTheme.borderColor),
              boxShadow: AppTheme.cardShadow,
            ),
            child: Column(
              children: [
                // Bio text
                Text(
                  "I'm a freelance Flutter developer with 4+ years of experience crafting beautiful, high-performance mobile and web applications. I partner with startups and businesses to transform their ideas into polished digital products.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.9,
                    fontSize: isMobile ? 16 : 18,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "My approach combines clean architecture, pixel-perfect UI implementation, and a deep understanding of user experience. I don't just write code—I build products that users love.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.9,
                    fontSize: isMobile ? 16 : 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 72),
          // Skills Section Title
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              'Tech Stack',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Technologies I work with',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
          ),
          const SizedBox(height: 40),
          // Skills Grid
          Wrap(
            spacing: 14,
            runSpacing: 14,
            alignment: WrapAlignment.center,
            children: _skills.map((skill) => _SkillChip(skill: skill)).toList(),
          ),
        ],
      ),
    );
  }

  static const List<_Skill> _skills = [
    _Skill('Flutter', Icons.flutter_dash, Color(0xFF02569B)),
    _Skill('Dart', Icons.code_rounded, Color(0xFF0175C2)),
    _Skill('Firebase', Icons.local_fire_department_rounded, Color(0xFFFFCA28)),
    _Skill('REST APIs', Icons.api_rounded, Color(0xFF22C55E)),
    _Skill('GraphQL', Icons.hub_rounded, Color(0xFFE535AB)),
    _Skill('Provider', Icons.account_tree_rounded, Color(0xFF7C5CFF)),
    _Skill('Riverpod', Icons.water_drop_rounded, Color(0xFF00D9FF)),
    _Skill('BLoC', Icons.widgets_rounded, Color(0xFF8B5CF6)),
    _Skill('GetX', Icons.speed_rounded, Color(0xFF8B5CF6)),
    _Skill('Git', Icons.fork_right_rounded, Color(0xFFF05032)),
    _Skill('CI/CD', Icons.autorenew_rounded, Color(0xFF00D9FF)),
    _Skill('Figma', Icons.design_services_rounded, Color(0xFFF24E1E)),
    _Skill('iOS', Icons.apple_rounded, Color(0xFF999999)),
    _Skill('Android', Icons.android_rounded, Color(0xFF3DDC84)),
    _Skill('Web', Icons.web_rounded, Color(0xFF7C5CFF)),
  ];
}

class _Skill {
  final String name;
  final IconData icon;
  final Color color;

  const _Skill(this.name, this.icon, this.color);
}

class _SkillChip extends StatefulWidget {
  final _Skill skill;

  const _SkillChip({required this.skill});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.05))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.skill.color.withOpacity(0.12)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isHovered
                ? widget.skill.color.withOpacity(0.5)
                : AppTheme.borderColor,
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.skill.color.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.skill.icon,
              size: 20,
              color: _isHovered ? widget.skill.color : AppTheme.textSecondary,
            ),
            const SizedBox(width: 10),
            Text(
              widget.skill.name,
              style: TextStyle(
                color: _isHovered ? widget.skill.color : AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
