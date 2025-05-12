import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';
import 'package:race_tracking_app/repository/firebase/firebase_participant_repository.dart';
import 'package:race_tracking_app/repository/firebase/firebase_segment_repository.dart';
import 'providers/participant_provider.dart';
import 'providers/segment_tracking_provider.dart';
import 'ui/screens/home_screen.dart';

void main() async {
  runApp(const RaceTrackingApp());
}

class RaceTrackingApp extends StatelessWidget {
  const RaceTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide ParticipantProvider with the repository
        ChangeNotifierProvider(
          create: (_) => ParticipantProvider(FirebaseParticipantRepository()),
        ),
        ChangeNotifierProvider(create: (_) => RaceProvider()),
        ChangeNotifierProvider(
          create:
              (_) => SegmentTrackingProvider(
                repository: FirebaseSegmentTrackingRepository(
                  baseUrl:
                      'https://racetrackingapp-84859-default-rtdb.asia-southeast1.firebasedatabase.app',
                  collection: 'participants',
                ),
              ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Race Tracking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
