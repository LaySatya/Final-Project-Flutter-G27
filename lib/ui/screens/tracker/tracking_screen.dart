import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';
import 'package:race_tracking_app/ui/screens/tracker/widgets/participant_bib_grid.dart';
import 'package:race_tracking_app/ui/screens/tracker/widgets/segment_detail.dart';
import 'package:race_tracking_app/ui/screens/tracker/widgets/segment_tap.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';
import 'package:race_tracking_app/ui/widgets/race_elapsed_time_topbar.dart';

// Main Tracking Screen
class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  SegmentType _currentSegment = SegmentType.swim;

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    final raceProvider = Provider.of<RaceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Time Tracking',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top bar showing elapsed race time
            RaceTopBar(formatElapsedTime: formatElapsedTime),

            // Segment Tabs
            SegmentTabs(
              currentSegment: _currentSegment,
              onSegmentChanged: (segment) {
                setState(() {
                  _currentSegment = segment;
                });
              },
            ),

            // Segment Detail 
            SegmentDetail(segment: _currentSegment),

            // Participant Grid for the current segment
            Expanded(
              child: ParticipantGrid(
                currentSegment: _currentSegment,
                formatElapsedTime: formatElapsedTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
