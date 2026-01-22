import 'dart:async';
import 'package:edochub_b2b/services/api_service.dart';
import 'package:edochub_b2b/widgets/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:edochub_b2b/widgets/modular_snackbar.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _selectedSegment = 0;
  bool _isLoading = true;
  List<dynamic> _appointments = [];
  List<dynamic> _filteredAppointments = [];
  final ApiService _apiService = ApiService();
  final List<String> _statuses = ['pending', 'confirmed', 'completed'];
  String _searchTerm = '';
  Timer? _debouncer;

  @override
  void initState() {
    super.initState();
    _fetchAppointments(_statuses[_selectedSegment]);
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    super.dispose();
  }

  Future<void> _fetchAppointments(String status) async {
    setState(() {
      _isLoading = true;
      _appointments = [];
      _filteredAppointments = [];
    });
    try {
      final data = await _apiService.get('appointments?status=$status');
      if (!mounted) return;
      setState(() {
        _appointments = data;
        _filteredAppointments = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      showModularSnackbar(context, 'Failed to load appointments', type: SnackbarType.error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterAppointments() {
    List<dynamic> filteredList = [];
    if (_searchTerm.isEmpty) {
      filteredList = _appointments;
    } else {
      filteredList = _appointments
          .where((appointment) =>
              appointment['name']!.toLowerCase().contains(_searchTerm.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredAppointments = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                _debouncer?.cancel();
                _debouncer = Timer(const Duration(milliseconds: 500), () {
                  setState(() {
                    _searchTerm = value;
                  });
                  _filterAppointments();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by patient or date',
                prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface.withAlpha(153)),
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildAppointmentsList(),
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
          _fetchAppointments(_statuses[index]);
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
                      : Theme.of(context).colorScheme.onSurface.withAlpha(153),
                ),
              ),
              if (count != null) ...[
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: isSelected
                      ? Theme.of(context).colorScheme.onPrimary.withAlpha(51)
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
    if (_filteredAppointments.isEmpty) {
      return const Center(
        child: Text('No appointments found.'),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      itemCount: _filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = _filteredAppointments[index];
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
