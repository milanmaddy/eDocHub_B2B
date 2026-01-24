import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHandlerScreen extends StatefulWidget {
  const LocationHandlerScreen({super.key});

  @override
  State<LocationHandlerScreen> createState() => _LocationHandlerScreenState();
}

class _LocationHandlerScreenState extends State<LocationHandlerScreen> {
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    try {
      final status = await Permission.location.status;
      if (status.isGranted) {
        _navigateToNextScreen();
      } else {
        _requestLocationPermission();
      }
    } catch (e) {
      debugPrint('Error checking location permission: $e');
      _navigateToNextScreen();
    }
  }

  Future<void> _requestLocationPermission() async {
    try {
      final status = await Permission.location.request();
      if (status.isGranted) {
        _navigateToNextScreen();
      } else {
        // Handle the case where the user denies the permission
        // For now, we'll just navigate to the welcome screen.
        _navigateToNextScreen();
      }
    } catch (e) {
      debugPrint('Error requesting location permission: $e');
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
