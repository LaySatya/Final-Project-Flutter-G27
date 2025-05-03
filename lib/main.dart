import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';
import 'package:race_tracking_app/repository/firebase/firebase_participant_repository.dart';
import 'package:race_tracking_app/repository/mock_participant_repository.dart';
import 'package:race_tracking_app/repository/mock_segment_tracking_repository.dart';
import 'models/segment.dart';
import 'providers/participant_provider.dart';
import 'providers/segment_tracking_provider.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(const RaceTrackingApp());
  
}

class RaceTrackingApp extends StatelessWidget {
  const RaceTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the segments
    List<Segment> segments = [
      Segment(type: SegmentType.swim),
      Segment(type: SegmentType.cycle),
      Segment(type: SegmentType.run),
    ];

    // Create the repository with the segments
    final segmentTrackingRepository = MockSegmentTrackingRepository();

    return MultiProvider(
      providers: [
        // Provide ParticipantProvider with the repository
        ChangeNotifierProvider(create: (_) => ParticipantProvider(FirebaseParticipantRepository())),
        ChangeNotifierProvider(create: (_) => RaceProvider()),
        ChangeNotifierProvider(create: (_) => SegmentTrackingProvider(repository: segmentTrackingRepository)),
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
