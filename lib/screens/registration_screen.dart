import 'package:edochub_b2b/screens/main_app_screen.dart';
import 'package:edochub_b2b/screens/mobile_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields controllers and variables
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _ageController = TextEditingController();
  DateTime? _selectedDateOfBirth;
  String? _selectedServiceType;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _maritalStatuses = ['Single', 'Married', 'Divorced', 'Widowed'];
  final List<String> _serviceTypes = [
    'Doctor',
    'Nurse',
    'Paramedical Staff',
    'Ambulance',
    'Therapist',
    'Pharmacist',
    'Lab Technician'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: Theme.of(context).colorScheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  int _calculateAge(DateTime dateOfBirth) {
    final today = DateTime.now();
    int age = today.year - dateOfBirth.year;
    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  void _showAgeRestrictionDialog() {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Age Restriction'),
        content: const Text(
          'You must be at least 18 years old to register for this service. Please try again when you turn 18.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.primary),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: AnimationLimiter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    Text(
                      'Create Your Account',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill in the details below to get started.',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: theme.colorScheme.onSurface.withAlpha(153)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration('Full Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: _inputDecoration('Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _ageController,
                      decoration: _inputDecoration('Age'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration('Gender'),
                      items: _genders.map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (newValue) {},
                      validator: (value) =>
                          value == null ? 'Please select a gender' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration('Marital Status'),
                      items: _maritalStatuses.map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (newValue) {},
                      validator: (value) =>
                          value == null ? 'Please select a marital status' : null,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: _inputDecoration(
                            _selectedDateOfBirth == null
                                ? 'Select Date of Birth'
                                : 'DOB: ${_selectedDateOfBirth!.toLocal()}'
                                    .split(' ')[0],
                          ).copyWith(
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                          validator: (value) {
                            if (_selectedDateOfBirth == null) {
                              return 'Please select your date of birth';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration('Service Type'),
                      items: _serviceTypes.map((String service) {
                        return DropdownMenuItem<String>(
                          value: service,
                          child: Text(service),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedServiceType = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select a service type' : null,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Check if user is at least 18 years old
                          final age = _calculateAge(_selectedDateOfBirth!);
                          if (age < 18) {
                            _showAgeRestrictionDialog();
                            return;
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MobileVerificationScreen(
                                  serviceType: _selectedServiceType!)));
                        }
                      },
                      child: Text('Continue',
                          style: TextStyle(fontSize: 16, color: theme.colorScheme.onPrimary)),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const MainAppScreen()),
                        );
                      },
                      child: Text(
                        'Skip for now',
                        style: TextStyle(
                            color: theme.colorScheme.primary, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: theme.colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
      ),
      labelStyle: TextStyle(color: theme.colorScheme.onSurface.withAlpha(153)),
    );
  }
}
