import 'package:edochub_b2b/widgets/modular_button.dart';
import 'package:flutter/material.dart';
import 'package:edochub_b2b/utils/color_extensions.dart';

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
      "title": "Welcome to eDoc Hub B2B",
      "description":
          "The all-in-one solution for managing your practice, starting with seamless appointment scheduling."
    },
    {
      "icon": "video_call",
      "title": "Connect with Patients",
      "description":
          "Engage in secure video consultations and manage your patient records all in one place."
    },
    {
      "icon": "work_history",
      "title": "Streamline Your Workflow",
      "description":
          "Manage your agenda, consultation history, and profile with ease. Built for professionals like you."
    }
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'eDoc Hub B2B',
                            style: textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 420,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: _pages.length,
                            onPageChanged: (index) {
                              setState(() => _currentPage = index);
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
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _pages.length,
                            (index) => _buildDot(index: index),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ModularButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text('Create Account'),
                        ),
                        const SizedBox(height: 16),
                        ModularButton(
                          buttonType: ButtonType.outlined,
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text('Log In'),
                        ),
                        const SizedBox(height: 8),
                        ModularButton(
                          buttonType: ButtonType.text,
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/main');
                          },
                          child: const Text('Skip for now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
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
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.3),
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
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 60,
            color: colorScheme.onPrimary,
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
            color: colorScheme.onSurface.withOpacitySafe(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
