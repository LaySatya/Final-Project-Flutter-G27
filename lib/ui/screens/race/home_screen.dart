import 'package:flutter/material.dart';
import 'package:race_tracking_app/ui/screens/race/dashboard_screen.dart';
import 'package:race_tracking_app/ui/widgets/actions/race_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Race Tracking App',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Image.network(
                "https://th.bing.com/th/id/R.13ad6c30d18f4f97b6067ad65e0ae751?rik=B%2bjT3qTAZx8UeQ&riu=http%3a%2f%2fwww.race2college.org%2fwp-content%2fuploads%2f2012%2f10%2fcropped-race2college1.jpg&ehk=ncfN53JcRRdk8EYjncQjG06deZeK4Hq%2f9kLtY9fbPCQ%3d&risl=&pid=ImgRaw&r=0",
              ),
              SizedBox(height: 40),
              RaceButton(
                text: "Dashboard",
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
