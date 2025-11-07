import 'package:edochub_b2b/screens/appointments_screen.dart';
import 'package:edochub_b2b/screens/messages_screen.dart';
import 'package:edochub_b2b/screens/notifications_screen.dart';
import 'package:edochub_b2b/screens/profile_screen.dart';
import 'package:edochub_b2b/widgets/dashboard_header.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';
import 'package:edochub_b2b/widgets/stylish_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;
  String _location = 'Loading location...'; // Initial display text

  @override
  void initState() {
    super.initState();
    _determinePosition(); // Fetch location when the screen loads
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      setState(() {
        _location = 'Location is disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        setState(() {
          _location = 'Location permission denied.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      setState(() {
        _location = 'Location permissions are denied forever.';
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      ).timeout(const Duration(seconds: 10));

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      if (mounted) {
        setState(() {
          _location = "${place.locality}, ${place.administrativeArea}";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _location = 'Could not get location.';
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNotificationsPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const DashboardScreen(),
      const AppointmentsScreen(),
      Scaffold(
          body: Center(
              child: Text('Patients Screen',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface)))),
      const MessagesScreen(),
      ProfileScreen(onBack: () => _onItemTapped(0)),
    ];

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            DashboardHeader(
              userName: 'Dr. Soumik Maity',
              userLocation: _location, // Pass the location state
              onNotificationsPressed: _onNotificationsPressed,
              onProfileTap: () => _onItemTapped(4),
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: screens,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: StylishBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            activeIcon: Icon(Icons.people_alt),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ... (Rest of the file remains the same)
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Mock data for carousel banners
  final List<Map<String, String>> _banners = [
    {
      "image": "https://placehold.co/600x200/png",
      "title": "New Feature Available",
      "subtitle": "Try our new video consultation service."
    },
    {
      "image": "https://placehold.co/600x200/png",
      "title": "Upcoming Conference",
      "subtitle": "Join us at the annual healthcare summit."
    },
    {
      "image": "https://placehold.co/600x200/png",
      "title": "Health Tip of the Day",
      "subtitle": "Stay hydrated for better overall health."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AnimationLimiter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              const SizedBox(height: 16),
              _buildStatsCards(context),
              const SizedBox(height: 24),
              _buildCarousel(context),
              const SizedBox(height: 24),
              _buildUpNext(context),
              const SizedBox(height: 24),
              _buildTodaysAgenda(context),
              const SizedBox(height: 90), // Extra space to see content behind navbar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    return Wrap(
      spacing: 16.0, // Horizontal space between cards
      runSpacing: 16.0, // Vertical space between cards
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 28, // Responsive width
          child: StatCard(
              title: 'Total Appointments',
              value: '12',
              color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 28, // Responsive width
          child: StatCard(
              title: 'Video Calls',
              value: '5',
              color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 28, // Responsive width
          child: StatCard(
              title: 'Messages',
              value: '3',
              color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      banner['image']!,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Theme.of(context).colorScheme.surface.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            banner['title']!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            banner['subtitle']!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
                (index) => _buildDot(index: index),
          ),
        ),
      ],
    );
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
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildUpNext(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Up Next',
            style:
            textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0,5),
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Video Consultation',
                    style: textTheme.titleMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.timer_outlined,
                            color: Theme.of(context).colorScheme.secondary, size: 16),
                        const SizedBox(width: 4),
                        Text('In 5 min',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text('Aarav Sharma', style: textTheme.titleLarge),
              const SizedBox(height: 4),
              Text('10:00 AM - 10:30 AM',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ModularButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_call_outlined),
                          SizedBox(width: 8),
                          Text('Join Call'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ModularButton(
                      buttonType: ButtonType.outlined,
                      onPressed: () {},
                      child: const Text('View Details'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTodaysAgenda(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today\'s Agenda',
            style:
            textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildAgendaItem(context, 'Rohan Patel', '11:00 AM - In-person',
            Icons.person_outline),
        _buildAgendaItem(context, 'Priya Singh', '1:30 PM - Video Call',
            Icons.videocam_outlined),
      ],
    );
  }

  Widget _buildAgendaItem(
      BuildContext context, String name, String time, IconData icon) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(name),
        subtitle: Text(time,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
        trailing: Icon(Icons.chevron_right,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
        onTap: () {},
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatCard(
      {super.key,
        required this.title,
        required this.value,
        required this.color});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: textTheme.bodyMedium?.copyWith(
                    color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
            const SizedBox(height: 8),
            Text(
              value,
              style: textTheme.headlineMedium
                  ?.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}