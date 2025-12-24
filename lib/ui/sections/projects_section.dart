import 'package:flutter/material.dart';
import '../data/projects.dart';
import '../widgets/section_container.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ProjectsSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      title: 'My Work',
      subtitle: 'Featured projects I\'ve worked on',
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive grid: 1 col mobile, 2 tablet, 3 desktop
          int crossAxisCount;
          if (constraints.maxWidth < 600) {
            crossAxisCount = 1;
          } else if (constraints.maxWidth < 900) {
            crossAxisCount = 2;
          } else {
            crossAxisCount = 3;
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: crossAxisCount == 1 ? 1.4 : 0.9,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index]);
            },
          );
        },
      ),
    );
  }
}
