import 'package:edochub_b2b/utils/color_extensions.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DateTime? _selectedDateOfBirth;

  int _calculateAge(DateTime dateOfBirth) {
    final today = DateTime.now();
    int age = today.year - dateOfBirth.year;
    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      age--;
    }
    return age;
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

  void _showAgeRestrictionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Access Denied'),
        content: const Text(
          'You must be at least 18 years old to use this service. We are unable to process your login request.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _selectedDateOfBirth = null;
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: AnimationLimiter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 375),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          const Spacer(),
                          Text(
                            'Welcome Back',
                            style: textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Log in to your account to continue',
                            style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface.withOpacitySafe(0.7)),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.username, AutofillHints.email],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: _selectedDateOfBirth == null
                                      ? 'Verify Date of Birth (Required, 18+ only)'
                                      : 'DOB: ${_selectedDateOfBirth!.toLocal()}'.split(' ')[0],
                                  prefixIcon: const Icon(Icons.calendar_today),
                                  suffixIcon: const Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ModularButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              
                              // Check if date of birth was selected
                              if (_selectedDateOfBirth == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please verify your date of birth to proceed'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                return;
                              }

                              // Check if user is at least 18 years old
                              final age = _calculateAge(_selectedDateOfBirth!);
                              if (age < 18) {
                                _showAgeRestrictionDialog();
                                return;
                              }

                              Navigator.pushReplacementNamed(context, '/main');
                            },
                            child: const Text('Log In'),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?",
                                  style: textTheme.bodyMedium),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: const Text('Sign Up'),
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
