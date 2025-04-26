import 'package:flutter/material.dart';
import 'package:race_tracking_app/ui/widgets/bottom_navbar.dart';
import 'package:race_tracking_app/ui/widgets/race/participant_list.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const ParticipantList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add participant screen
          Navigator.pushNamed(context, '/addParticipant');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
