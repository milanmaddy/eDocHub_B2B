import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Mock data for onboarding pages
  final List<Map<String, String>> _pages = [
    {
      "icon": "calendar_today",
      "title": "Welcome to eDoc Hub",
      "description": "The all-in-one solution for managing your practice, starting with seamless appointment scheduling."
    },
    {
      "icon": "video_call",
      "title": "Connect with Patients",
      "description": "Engage in secure video consultations and manage your patient records all in one place."
    },
    {
      "icon": "work_history",
      "title": "Streamline Your Workflow",
      "description": "Manage your agenda, consultation history, and profile with ease. Built for professionals like you."
    }
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Top Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'eDoc Hub',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              // PageView for Onboarding Content
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _OnboardingPage(
                      icon: _getIconData(_pages[index]["icon"]!),
                      title: _pages[index]["title"]!,
                      description: _pages[index]["description"]!,
                    );
                  },
                ),
              ),
              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                      (index) => _buildDot(index: index),
                ),
              ),
              const Spacer(),
              // Bottom Buttons
              Column(
                children: [
                    onPressed: () {
                      // Navigate to the Login/Register screen
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Create Account'),
                  ),
                  const SizedBox(height: 16),
                    onPressed: () {
                      // Navigate to the Login/Register screen
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Log In'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Skip login and go to the main app (for demo/guest access)
                      Navigator.pushReplacementNamed(context, '/main');
                    },
                    child: Text(
                      'Skip for now',
                      style: textTheme.bodyMedium
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case "calendar_today":
        return Icons.calendar_today_outlined;
      case "video_call":
        return Icons.video_call_outlined;
      case "work_history":
        return Icons.work_history_outlined;
      default:
        return Icons.apps;
    }
  }

  Widget _buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 140,
          height: 140,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 60,
          ),
        ),
        const SizedBox(height: 48),
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: textTheme.bodyLarge?.copyWith(
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}