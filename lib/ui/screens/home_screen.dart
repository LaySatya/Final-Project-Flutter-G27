import 'package:flutter/material.dart';
import 'package:race_tracking_app/ui/screens/participant/participant_screen.dart';
import 'package:race_tracking_app/ui/screens/race/race_screen.dart';
import 'package:race_tracking_app/ui/screens/result/result_screen.dart';
import 'package:race_tracking_app/ui/screens/tracker/tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ParticipantsScreen(),
    RaceControlScreen(),
    TrackingScreen(),
    ResultScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Participants',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Race'),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Tracking'),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Results',
          ),
        ],
      ),
    );
  }
}
