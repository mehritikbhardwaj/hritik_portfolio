# Portfolio Web - Hritik Bhardwaj

A modern, responsive portfolio website built with Flutter Web.

## Features

- 🎨 Modern dark theme with Material 3
- 📱 Fully responsive design (mobile, tablet, desktop)
- 🚀 Smooth scroll navigation
- 🎯 Clean folder structure
- ⚡ Fast loading and performant

## Sections

1. **Hero** - Introduction with CTA buttons
2. **About** - Bio and skills/technologies
3. **Projects** - Portfolio showcase with responsive grid
4. **Experience** - Timeline-style work history
5. **Contact** - Contact information and email CTA

## Getting Started

### Prerequisites

- Flutter SDK (3.9+)
- Chrome browser (for web development)

### Installation

```bash
# Clone the repository
git clone https://github.com/mehritikbhardwaj/portfolio_hritik.git

# Navigate to project directory
cd portfolio_hritik

# Install dependencies
flutter pub get

# Run in Chrome
flutter run -d chrome
```

## Customization

### Update Personal Information

1. **Hero Section**: Edit `lib/ui/sections/hero_section.dart`
2. **About Section**: Edit `lib/ui/sections/about_section.dart`
3. **Projects**: Edit `lib/ui/data/projects.dart`
4. **Experience**: Edit `lib/ui/data/experience.dart`
5. **Contact**: Edit `lib/ui/sections/contact_section.dart`

### Update Resume

Replace `web/assets/resume.pdf` with your actual resume file.

### Update Theme

Edit `lib/ui/theme/app_theme.dart` to customize:
- Primary color (accent)
- Background colors
- Text colors
- Border radius

## Deployment

### GitHub Pages

1. Build the web app:
```bash
flutter build web --release --base-href "/portfolio_hritik/"
```
> Replace `portfolio_hritik` with your repository name.

2. Push the `build/web` folder to the `gh-pages` branch:
```bash
cd build/web
git init
git add .
git commit -m "Deploy to GitHub Pages"
git branch -M gh-pages
git remote add origin https://github.com/mehritikbhardwaj/portfolio_hritik.git
git push -f origin gh-pages
```

3. Go to **Settings > Pages** in your GitHub repository and select `gh-pages` branch.

### Firebase Hosting

1. Install Firebase CLI:
```bash
npm install -g firebase-tools
```

2. Login to Firebase:
```bash
firebase login
```

3. Initialize Firebase Hosting:
```bash
firebase init hosting
```
   - Select your project
   - Set public directory to `build/web`
   - Configure as single-page app: **Yes**
   - Do NOT overwrite `index.html`

4. Build the web app:
```bash
flutter build web --release
```

5. Deploy:
```bash
firebase deploy
```

### Vercel

1. Build the web app:
```bash
flutter build web --release
```

2. Install Vercel CLI:
```bash
npm install -g vercel
```

3. Deploy:
```bash
cd build/web
vercel
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
└── ui/
    ├── data/
    │   ├── experience.dart      # Work experience data
    │   └── projects.dart        # Projects data
    ├── sections/
    │   ├── about_section.dart   # About + Skills section
    │   ├── contact_section.dart # Contact section
    │   ├── experience_section.dart # Experience timeline
    │   ├── hero_section.dart    # Hero/landing section
    │   └── projects_section.dart # Projects grid
    ├── theme/
    │   └── app_theme.dart       # Theme configuration
    └── widgets/
        ├── buttons.dart         # Custom button widgets
        ├── nav_bar.dart         # Navigation bar
        ├── pill.dart            # Skill/tech pill widget
        ├── project_card.dart    # Project card widget
        └── section_container.dart # Section wrapper
```

## Technologies Used

- **Flutter** - UI Framework
- **Dart** - Programming Language
- **Google Fonts** - Typography (Inter)
- **URL Launcher** - External links

## License

This project is open source and available under the [MIT License](LICENSE).

---

Made with ❤️ using Flutter
