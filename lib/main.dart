import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/participant_provider.dart';
import 'providers/race_provider.dart';
import 'ui/screens/home_screen.dart'; // We'll create this too

void main() {
  runApp(const RaceTrackingApp());
}

class RaceTrackingApp extends StatelessWidget {
  const RaceTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ParticipantProvider()),
        ChangeNotifierProvider(create: (_) => RaceProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Race Tracking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(), // first screen user sees
      ),
    );
  }
}
