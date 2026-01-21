import 'package:flutter/material.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';
import 'package:edochub_b2b/utils/theme_manager.dart';
import 'package:edochub_b2b/utils/color_extensions.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onBack;
  const ProfileScreen({super.key, required this.onBack});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildStatusToggle(),
            const SizedBox(height: 24),
            const ExpansionTileCard(
              title: 'Personal Information',
              initiallyExpanded: true,
              children: [
                ProfileTextField(label: 'Full Name', initialValue: 'Dr. Jane Doe'),
                SizedBox(height: 16),
                ProfileTextField(
                    label: 'Medical License Number',
                    initialValue: 'A123-456-789'),
                SizedBox(height: 16),
                ProfileTextField(
                  label: 'Professional Bio',
                  initialValue:
                      'Dedicated General Practitioner with over 10 years of experience in family medicine and patient care.',
                  maxLines: 4,
                ),
              ],
            ),
            const SizedBox(height: 12),
            ExpansionTileCard(
              title: 'Specializations',
              children: [
                // Add specialization fields here
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Specialization content goes here.',
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6))),
                )
              ],
            ),
            const SizedBox(height: 12),
            ExpansionTileCard(
              title: 'Availability & Contact',
              children: [
                // Add availability and contact fields here
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Availability & Contact content goes here.',
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6))),
                )
              ],
            ),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: SwitchListTile(
                title: const Text('Dark Mode'),
                value: themeNotifier.value == ThemeMode.dark,
                onChanged: (value) {
                  themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                },
              ),
            ),
            const SizedBox(height: 40),
            ModularButton(
              onPressed: () {},
              child: const Text('Save Changes'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://placehold.co/100x100/png'), // Placeholder
            ),
            Positioned(
              bottom: 0,
              right: -5,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Dr. Jane Doe, MD',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'General Practitioner',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6), fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildStatusToggle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isOnline = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isOnline ? Theme.of(context).colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isOnline)
                      const CircleAvatar(
                          radius: 4, backgroundColor: Colors.green),
                    const SizedBox(width: 8),
                    const Text('Online',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isOnline = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !isOnline ? Theme.of(context).cardColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child:
                        Text('Away', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6)))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpansionTileCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;

  const ExpansionTileCard({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        title: Text(title,
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final int maxLines;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.initialValue,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6))),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.2)),
            ),
          ),
        ),
      ],
    );
  }
}