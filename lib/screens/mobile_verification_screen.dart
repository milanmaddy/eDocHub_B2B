import 'package:edochub_b2b/screens/document_upload_screen.dart';
import 'package:edochub_b2b/screens/main_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';

class MobileVerificationScreen extends StatefulWidget {
  final String serviceType;

  const MobileVerificationScreen({super.key, required this.serviceType});

  @override
  MobileVerificationScreenState createState() => MobileVerificationScreenState();
}

class MobileVerificationScreenState extends State<MobileVerificationScreen> {
  final _mobileNumberController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Verification'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _mobileNumberController,
              decoration: const InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            ModularButton(
              onPressed: () {
                // Send OTP logic
              },
              child: const Text('Send OTP'),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _otpController,
              decoration: const InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ModularButton(
              onPressed: () {
                // Verify OTP logic

                if (widget.serviceType == 'Doctor') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DocumentUploadScreen(serviceType: widget.serviceType)));
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MainAppScreen()),
                  );
                }
              },
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
