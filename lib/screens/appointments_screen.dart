import 'package:flutter/material.dart';
import 'package:edochub_b2b/models/appointment_model.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';

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
        leading: const BackButton(),
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: SearchBar(),
          ),
          AppointmentTabBar(tabController: _tabController),
          Expanded(
            child: AppointmentTabBarView(tabController: _tabController),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search by patient or date',
        prefixIcon:
            Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class AppointmentTabBar extends StatelessWidget {
  final TabController tabController;
  const AppointmentTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: Theme.of(context).colorScheme.primary,
      labelColor: Theme.of(context).colorScheme.onSurface,
      unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
      tabs: [
        _buildTab('Pending', '3'),
        _buildTab('Confirmed'),
        _buildTab('Completed'),
      ],
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
              backgroundColor: Colors.orange,
              child: Text(count,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
          ]
        ],
      ),
    );
  }
}

class AppointmentTabBarView extends StatelessWidget {
  final TabController tabController;
  const AppointmentTabBarView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        const AppointmentList(), // Pending appointments
        Center(
            child: Text('Confirmed Appointments',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)))),
        Center(
            child: Text('Completed Appointments',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)))),
      ],
    );
  }
}

class AppointmentList extends StatelessWidget {
  const AppointmentList({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final appointments = [
      const Appointment(
        name: 'Rohan Patel',
        time: 'Tomorrow, 10:30 AM',
        type: 'Video Consultation',
        avatarUrl: 'https://placehold.co/100x100/png',
      ),
      const Appointment(
        name: 'Priya Singh',
        time: 'Tomorrow, 2:00 PM',
        type: 'In-Person Visit',
        avatarUrl: 'https://placehold.co/100x100/png',
      ),
      const Appointment(
        name: 'Advik Gupta',
        time: 'Nov 28, 9:00 AM',
        type: 'Video Consultation',
        avatarUrl: 'https://placehold.co/100x100/png',
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return AppointmentCard(appointment: appointment);
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
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
                  backgroundImage: NetworkImage(appointment.avatarUrl),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appointment.name,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('${appointment.time}\n${appointment.type}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ModularButton(
                    onPressed: () {},
                    buttonType: ButtonType.outlined,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      side: BorderSide(color: Theme.of(context).colorScheme.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ModularButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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