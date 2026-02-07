import 'package:edochub_b2b/widgets/expansion_tile_card.dart';
import 'package:edochub_b2b/widgets/profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';
import 'package:edochub_b2b/services/api_service.dart';
import 'package:edochub_b2b/widgets/modular_snackbar.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onBack;
  const ProfileScreen({super.key, required this.onBack});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isOnline = true;
  final _nameController = TextEditingController(text: 'Dr. Jane Doe');
  final _licenseController = TextEditingController(text: 'A123-456-789');
  final _bioController = TextEditingController(
    text:
        'Dedicated General Practitioner with over 10 years of experience in family medicine and patient care.',
  );
  final _emailController = TextEditingController(text: 'jane.doe@example.com');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _addressController = TextEditingController(text: 'Kolkata, West Bengal');
  final _specializationController = TextEditingController(text: 'General Medicine');
  final ApiService _api = ApiService();

  @override
  void dispose() {
    _nameController.dispose();
    _licenseController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildStatusToggle(),
              const SizedBox(height: 24),
              ExpansionTileCard(
                title: 'Personal Information',
                initiallyExpanded: true,
                children: [
                  ProfileTextField(label: 'Full Name', initialValue: _nameController.text),
                  const SizedBox(height: 16),
                  ProfileTextField(label: 'Medical License Number', initialValue: _licenseController.text),
                  const SizedBox(height: 16),
                  ProfileTextField(label: 'Professional Bio', initialValue: _bioController.text, maxLines: 4),
                ],
              ),
              const SizedBox(height: 12),
              ExpansionTileCard(
                title: 'Specializations',
                children: [
                  ProfileTextField(label: 'Primary Specialization', initialValue: _specializationController.text),
                ],
              ),
              const SizedBox(height: 12),
              ExpansionTileCard(
                title: 'Availability & Contact',
                children: [
                  ProfileTextField(label: 'Email', initialValue: _emailController.text),
                  const SizedBox(height: 16),
                  ProfileTextField(label: 'Phone', initialValue: _phoneController.text),
                  const SizedBox(height: 16),
                  ProfileTextField(label: 'Address', initialValue: _addressController.text),
                ],
              ),
              const SizedBox(height: 40),
              ModularButton(
                onPressed: _saveProfile,
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 20),
            ],
          ),
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
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 50,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Positioned(
              bottom: 0,
              right: -5,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.onPrimary, size: 16),
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
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(153), fontSize: 16),
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
                        Text('Away', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(153)))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final payload = {
      'name': _nameController.text.trim(),
      'license': _licenseController.text.trim(),
      'bio': _bioController.text.trim(),
      'specialization': _specializationController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'address': _addressController.text.trim(),
      'status': isOnline ? 'online' : 'away',
    };
    try {
      await _api.put('profile', payload);
      if (!mounted) return;
      showModularSnackbar(context, 'Profile saved', type: SnackbarType.success);
    } catch (e) {
      if (!mounted) return;
      showModularSnackbar(context, 'Failed to save profile', type: SnackbarType.error);
    }
  }
}
