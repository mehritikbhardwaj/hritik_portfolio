class Project {
  final String title;
  final String description;
  final String category;
  final List<String> techStack;
  final String imagePath;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? webUrl;

  const Project({
    required this.title,
    required this.description,
    required this.category,
    required this.techStack,
    required this.imagePath,
    this.playStoreUrl,
    this.appStoreUrl,
    this.webUrl,
  });
}

const List<Project> projects = [
  // ================= FINTECH / ENTERPRISE =================
  Project(
    title: 'EFL Clik',
    description:
        'Enterprise fintech application for loan onboarding, customer creation, lead management, and complete loan lifecycle management.',
    category: 'Fintech • Enterprise',
    techStack: ['Flutter', 'REST APIs', 'Firebase'],
    imagePath: 'web/assets/projects/efl_clik.png',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.efl.oneapp',
    appStoreUrl: 'https://apps.apple.com/in/app/efl-clik/id6449164257',
    webUrl: 'https://clik.efl.co.in/login',
  ),

  Project(
    title: 'EFL Connections',
    description:
        'Internal enterprise app for partner, vendor, and business channel management with secure role-based access.',
    category: 'Fintech • Enterprise',
    techStack: ['Flutter', 'REST APIs'],
    imagePath: 'web/assets/projects/efl_connections.png',
    playStoreUrl: null,
    appStoreUrl: null,
    webUrl: null,
  ),

  Project(
    title: 'EFL LeadPro',
    description:
        'Lead management system for sales teams to manage prospects, follow-ups, and loan conversion pipelines.',
    category: 'Fintech • CRM',
    techStack: ['Flutter', 'REST APIs'],
    imagePath: 'web/assets/projects/efl_leadpro.png',
    playStoreUrl: null,
    appStoreUrl: null,
    webUrl: null,
  ),

  // ================= LOGISTICS / OPERATIONS =================
  Project(
    title: 'Raftaarr',
    description:
        'Operations and logistics management application for workforce tracking, task assignment, and real-time status updates.',
    category: 'Logistics • Operations',
    techStack: ['React Native', 'REST APIs'],
    imagePath: 'web/assets/projects/raftaarr.png',
    playStoreUrl: null,
    appStoreUrl: null,
    webUrl: null,
  ),

  // ================= DELIVERY / QUICK COMMERCE =================
  Project(
    title: 'HelloDish – Food Delivery',
    description:
        'Food delivery platform with restaurant listings, live order tracking, delivery partner flows, and integrated payments.',
    category: 'Delivery • Consumer App',
    techStack: ['Flutter', 'Firebase', 'Maps', 'Payments'],
    imagePath: 'web/assets/projects/hellodish.png',
    playStoreUrl: null,
    appStoreUrl: null,
    webUrl: null,
  ),

  Project(
    title: 'JK FastMart',
    description:
        'Quick-commerce grocery and essentials delivery app with real-time inventory, order tracking, and multi-vendor support.',
    category: 'Quick Commerce • Retail',
    techStack: ['Flutter', 'REST APIs', 'Payments'],
    imagePath: 'web/assets/projects/jk_fastmart.png',
    playStoreUrl: null, // add if public
    appStoreUrl: null,
    webUrl: null,
  ),

  // ================= SOCIAL / AI =================
  Project(
    title: 'The LIT App – AI Photo Sharing',
    description:
        'AI-powered photo sharing application with smart filters, face recognition, shared albums, and auto-sharing features.',
    category: 'Social • AI • Media',
    techStack: ['Flutter', 'Firebase', 'AI/ML'],
    imagePath: 'web/assets/projects/lit_app.png',
    playStoreUrl: null,
    appStoreUrl: null,
    webUrl: null,
  ),

  // ================= MARKETPLACE / CATALOG =================
  Project(
    title: 'Gabriel E-Catalogue',
    description:
        'High-scale automotive product catalogue app used by dealers to browse, search, and manage a large inventory of products.',
    category: 'E-Commerce • High Scale',
    techStack: ['Flutter', 'REST APIs'],
    imagePath: 'web/assets/projects/gabriel.png',
    playStoreUrl: null, // high download count
    appStoreUrl: null,
    webUrl: null,
  ),

  // ================= REAL ESTATE =================
  Project(
    title: 'Landable',
    description:
        'Real estate analytics and business intelligence platform for brokers and retail investors.',
    category: 'Real Estate • Analytics',
    techStack: ['Flutter', 'REST APIs'],
    imagePath: 'web/assets/projects/landable.png',
    playStoreUrl: null,
    appStoreUrl: null,
    webUrl: null,
  ),
];
