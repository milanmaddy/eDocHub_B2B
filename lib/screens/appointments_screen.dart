import 'package:flutter/material.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';
import 'package:edochub_b2b/utils/color_extensions.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text('Appointments',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by patient or date',
                prefixIcon:
                    Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6)),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Tab Bar
            TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.onSurface,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6),
              tabs: [
                _buildTab('Pending', '3'),
                _buildTab('Confirmed'),
                _buildTab('Completed'),
              ],
            ),
            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAppointmentsList(), // Pending appointments
                  Center(
                      child: Text('Confirmed Appointments',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6)))),
                  Center(
                      child: Text('Completed Appointments',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6)))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Tab _buildTab(String title, [String? count]) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          if (count != null) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 10,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(count,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildAppointmentsList() {
    // Mock Data
    final appointments = [
      {
        'name': 'John Doe',
        'time': 'Tomorrow, 10:30 AM',
        'type': 'Video Consultation',
        'avatar': 'https://placehold.co/100x100/png'
      },
      {
        'name': 'Maria Garcia',
        'time': 'Tomorrow, 2:00 PM',
        'type': 'In-Person Visit',
        'avatar': 'https://placehold.co/100x100/png'
      },
      {
        'name': 'Kenji Tanaka',
        'time': 'Nov 28, 9:00 AM',
        'type': 'Video Consultation',
        'avatar': 'https://placehold.co/100x100/png'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return AppointmentCard(
          name: appointment['name']!,
          time: appointment['time']!,
          type: appointment['type']!,
          avatarUrl: appointment['avatar']!,
        );
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String name;
  final String time;
  final String type;
  final String avatarUrl;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.time,
    required this.type,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('$time\n$type',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ModularButton(
                    buttonType: ButtonType.outlined,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      side: BorderSide(color: Theme.of(context).colorScheme.error),
                    ),
                    onPressed: () {},
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ModularButton(
                    onPressed: () {},
                    child: const Text('Accept'),
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