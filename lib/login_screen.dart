import 'package:flutter/material.dart';
import 'package:edochub_b2b/modular_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              // Header
              Icon(Icons.shield_outlined,
                  color: Theme.of(context).colorScheme.primary, size: 40),
              const SizedBox(height: 16),
              Text(
                'eDoc Hub',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Securely Connecting Healthcare Professionals.',
                style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              ),
              const SizedBox(height: 32),

              // Tab Bar
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  tabs: const [
                    Tab(text: 'Log In'),
                    Tab(text: 'Register'),
                  ],
                ),
              ),

              // Tab Bar View
              SizedBox(
                height: 500, // Adjust height as needed
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLoginForm(context),
                    _buildRegisterForm(context), // Placeholder for registration
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          // Phone Number Field
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Phone Number',
              prefixIcon: Icon(Icons.phone_outlined, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          // Password Field
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              suffixIcon:
                  Icon(Icons.visibility_off_outlined, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            ),
          ),
          const SizedBox(height: 16),
          // Links
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Log in with Email'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Log In Button
          ModularButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/main');
            },
            child: const Text('Log In'),
          ),
          const SizedBox(height: 24),
          // Divider
          Row(
            children: [
              Expanded(child: Divider(color: Theme.of(context).cardColor)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('OR', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
              ),
              Expanded(child: Divider(color: Theme.of(context).cardColor)),
            ],
          ),
          const SizedBox(height: 24),
          // Google Log In Button
          ModularButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              side: BorderSide(color: Theme.of(context).cardColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/google_logo.png', height: 20),
                const SizedBox(width: 12),
                const Text('Log in with Google'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    // Placeholder for the registration form
    return Center(
      child: Text(
        'Registration form will go here.',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
      ),
    );
  }
}