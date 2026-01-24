import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:edochub_b2b/models/appointment_model.dart';
import 'package:edochub_b2b/utils/color_utils.dart';

void main() {
  group('Appointment Model Tests', () {
    test('Appointment creation with valid data', () {
      final appointment = Appointment(
        name: 'John Doe',
        time: '10:00 AM',
        type: 'Meeting',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      expect(appointment.name, 'John Doe');
      expect(appointment.time, '10:00 AM');
      expect(appointment.type, 'Meeting');
      expect(appointment.avatarUrl, 'https://example.com/avatar.jpg');
    });

    test('Appointment equality', () {
      final appointment1 = Appointment(
        name: 'Jane Smith',
        time: '2:00 PM',
        type: 'Consultation',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      final appointment2 = Appointment(
        name: 'Jane Smith',
        time: '2:00 PM',
        type: 'Consultation',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      expect(appointment1.name, appointment2.name);
      expect(appointment1.time, appointment2.time);
    });

    test('Appointment with different types', () {
      final appointmentTypes = ['Meeting', 'Consultation', 'Review', 'Inspection'];

      for (final type in appointmentTypes) {
        final appointment = Appointment(
          name: 'Test User',
          time: '3:00 PM',
          type: type,
          avatarUrl: 'https://example.com/avatar.jpg',
        );
        expect(appointment.type, type);
      }
    });
  });

  group('Color Utils Tests', () {
    test('Light background returns black text color', () {
      final lightColor = Colors.white;
      final textColor = getContrastingTextColor(lightColor);

      expect(textColor, Colors.black);
    });

    test('Dark background returns white text color', () {
      final darkColor = Colors.black;
      final textColor = getContrastingTextColor(darkColor);

      expect(textColor, Colors.white);
    });

    test('Mid-tone colors return appropriate text color', () {
      final midToneColor = Colors.grey;
      final textColor = getContrastingTextColor(midToneColor);

      // Grey is considered dark enough, should return white
      expect(textColor, Colors.white);
    });

    test('Blue color returns white text', () {
      final blueColor = Colors.blue;
      final textColor = getContrastingTextColor(blueColor);

      expect(textColor, Colors.white);
    });

    test('Yellow color returns black text', () {
      final yellowColor = Colors.yellow;
      final textColor = getContrastingTextColor(yellowColor);

      expect(textColor, Colors.black);
    });

    test('Red color returns white text', () {
      final redColor = Colors.red;
      final textColor = getContrastingTextColor(redColor);

      expect(textColor, Colors.white);
    });

    test('Light green returns white text', () {
      final lightGreen = Colors.lightGreen;
      final textColor = getContrastingTextColor(lightGreen);

      expect(textColor, Colors.white);
    });
  });

  group('String Validation Tests', () {
    test('Empty string validation', () {
      final emptyString = '';
      expect(emptyString.isEmpty, true);
    });

    test('Non-empty string validation', () {
      final nonEmptyString = 'eDocHub';
      expect(nonEmptyString.isNotEmpty, true);
      expect(nonEmptyString.length, 7);
    });

    test('Email validation pattern', () {
      final validEmail = 'user@example.com';
      final emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      final regex = RegExp(emailPattern);

      expect(regex.hasMatch(validEmail), true);
    });

    test('Invalid email validation', () {
      final invalidEmail = 'notanemail';
      final emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      final regex = RegExp(emailPattern);

      expect(regex.hasMatch(invalidEmail), false);
    });
  });

  group('List Operations Tests', () {
    test('Appointment list operations', () {
      final appointments = [
        Appointment(
          name: 'User 1',
          time: '9:00 AM',
          type: 'Meeting',
          avatarUrl: 'https://example.com/1.jpg',
        ),
        Appointment(
          name: 'User 2',
          time: '10:00 AM',
          type: 'Consultation',
          avatarUrl: 'https://example.com/2.jpg',
        ),
        Appointment(
          name: 'User 3',
          time: '11:00 AM',
          type: 'Review',
          avatarUrl: 'https://example.com/3.jpg',
        ),
      ];

      expect(appointments.length, 3);
      expect(appointments.first.name, 'User 1');
      expect(appointments.last.name, 'User 3');
    });

    test('Filter appointments by type', () {
      final appointments = [
        Appointment(
          name: 'User 1',
          time: '9:00 AM',
          type: 'Meeting',
          avatarUrl: 'https://example.com/1.jpg',
        ),
        Appointment(
          name: 'User 2',
          time: '10:00 AM',
          type: 'Meeting',
          avatarUrl: 'https://example.com/2.jpg',
        ),
        Appointment(
          name: 'User 3',
          time: '11:00 AM',
          type: 'Review',
          avatarUrl: 'https://example.com/3.jpg',
        ),
      ];

      final meetings = appointments.where((a) => a.type == 'Meeting').toList();
      expect(meetings.length, 2);
    });
  });
}
