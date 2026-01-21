import 'package:flutter/material.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';
import 'package:edochub_b2b/utils/color_extensions.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _buildSegmentedControl(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildAppointmentsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildSegment(0, 'Pending', '3'),
          _buildSegment(1, 'Confirmed'),
          _buildSegment(2, 'Completed'),
        ],
      ),
    );
  }

  Widget _buildSegment(int index, String title, [String? count]) {
    final isSelected = _selectedSegment == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedSegment = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).colorScheme.primary : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6),
                ),
              ),
              if (count != null) ...[
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: isSelected
                      ? Theme.of(context).colorScheme.onPrimary.withOpacitySafe(0.2)
                      : Theme.of(context).colorScheme.secondary,
                  child: Text(count,
                      style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
              ]
            ],
          ),
        ),
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