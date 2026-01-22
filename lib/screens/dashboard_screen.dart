import 'package:edochub_b2b/services/api_service.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';
import 'package:edochub_b2b/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  final ApiService _apiService = ApiService();
  int _currentPage = 0;
  bool _isLoadingBanners = true;
  List<dynamic> _banners = [];
  bool _isLoadingUpNext = true;
  Map<String, dynamic>? _upNextAppointment;
  bool _isLoadingAgenda = true;
  List<dynamic> _todaysAgenda = [];
  bool _isLoadingStats = true;
  Map<String, dynamic> _stats = {};

  @override
  void initState() {
    super.initState();
    _fetchBanners();
    _fetchUpNextAppointment();
    _fetchTodaysAgenda();
    _fetchStats();
  }

  Future<void> _fetchBanners() async {
    try {
      final data = await _apiService.get('banners');
      if (!mounted) return;
      setState(() {
        _banners = data;
        _isLoadingBanners = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingBanners = false;
      });
    }
  }

  Future<void> _fetchUpNextAppointment() async {
    try {
      final data = await _apiService.get('appointments/up-next');
      if (!mounted) return;
      setState(() {
        _upNextAppointment = data;
        _isLoadingUpNext = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingUpNext = false;
      });
    }
  }

  Future<void> _fetchTodaysAgenda() async {
    try {
      final data = await _apiService.get('appointments/today');
      if (!mounted) return;
      setState(() {
        _todaysAgenda = data;
        _isLoadingAgenda = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingAgenda = false;
      });
    }
  }

  Future<void> _fetchStats() async {
    try {
      final data = await _apiService.get('stats');
      if (!mounted) return;
      setState(() {
        _stats = data;
        _isLoadingStats = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingStats = false;
      });
    }
  }

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
    final colorScheme = Theme.of(context).colorScheme;
    if (_isLoadingStats) {
      return const Center(child: CircularProgressIndicator());
    }
    return Wrap(
      spacing: 16.0, // Horizontal space between cards
      runSpacing: 16.0, // Vertical space between cards
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 28, // Responsive width
          child: StatCard(
              title: 'Total Appointments',
              value: _stats['total_appointments']?.toString() ?? '0',
              color: colorScheme.primary),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 28, // Responsive width
          child: StatCard(
              title: 'Video Calls',
              value: _stats['video_calls']?.toString() ?? '0',
              color: colorScheme.secondary),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 28, // Responsive width
          child: StatCard(
              title: 'Messages',
              value: _stats['messages']?.toString() ?? '0',
              color: colorScheme.tertiary),
        ),
      ],
    );
  }

  Widget _buildCarousel(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (_isLoadingBanners) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_banners.isEmpty) {
      return const SizedBox.shrink();
    }

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
                            colorScheme.surface.withAlpha(230),
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
                              color: colorScheme.onSurface,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            banner['subtitle']!,
                            style: TextStyle(
                              color: colorScheme.onSurface.withAlpha(230),
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
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? colorScheme.primary
            : colorScheme.onSurface.withAlpha(77),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  String _getTimeRemaining(String time) {
    try {
      final now = DateTime.now();
      final parsedTime = DateFormat('HH:mm').parse(time);
      final appointmentTime = DateTime(now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);

      final difference = appointmentTime.difference(now);

      if (difference.isNegative) {
        return 'Now';
      } else if (difference.inMinutes < 60) {
        return 'In ${difference.inMinutes} min';
      } else {
        return 'In ${difference.inHours} hours';
      }
    } catch (e) {
      return '';
    }
  }

  Widget _buildUpNext(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Up Next',
            style:
            textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        if (_isLoadingUpNext)
          const Center(child: CircularProgressIndicator())
        else if (_upNextAppointment == null)
          const Center(child: Text('No upcoming appointments.'))
        else
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withAlpha(13),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _upNextAppointment!['type'],
                      style: textTheme.titleMedium
                          ?.copyWith(color: colorScheme.primary),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.timer_outlined,
                              color: colorScheme.onSecondary, size: 16),
                          const SizedBox(width: 4),
                          Text(
                              _getTimeRemaining(_upNextAppointment!['time']),
                              style: TextStyle(
                                  color: colorScheme.onSecondary,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(_upNextAppointment!['name'], style: textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(_upNextAppointment!['time'],
                    style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withAlpha(153))),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ModularButton(
                        onPressed: () {
                          // TODO: Implement join call functionality
                        },
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
                        onPressed: () {
                          // TODO: Implement view details functionality
                        },
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
        if (_isLoadingAgenda)
          const Center(child: CircularProgressIndicator())
        else if (_todaysAgenda.isEmpty)
          const Center(child: Text('No appointments for today.'))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _todaysAgenda.length,
            itemBuilder: (context, index) {
              final appointment = _todaysAgenda[index];
              return _buildAgendaItem(
                  context,
                  appointment['name'],
                  appointment['time'],
                  appointment['type'] == 'video'
                      ? Icons.videocam_outlined
                      : Icons.person_outline);
            },
          ),
      ],
    );
  }

  Widget _buildAgendaItem(
      BuildContext context, String name, String time, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primary,
          child: Icon(icon, color: colorScheme.onPrimary),
        ),
        title: Text(name),
        subtitle: Text(time,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: colorScheme.onSurface.withAlpha(153))),
        trailing:
        Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
        onTap: () {
          // TODO: Implement appointment details navigation
        },
      ),
    );
  }
}
