import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';
import 'package:race_tracking_app/ui/screens/tracker/widgets/participant_bib_grid.dart';
import 'package:race_tracking_app/ui/screens/tracker/widgets/segment_tab_button.dart';
import 'package:race_tracking_app/ui/widgets/race_elapsed_time_topbar.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';

class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  SegmentType _currentSegment = SegmentType.swim;

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    final participants = participantProvider.participants;
    final raceProvider = Provider.of<RaceProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Time Tracking')),
      body: Column(
        children: [
          // topbar show elapsed race time widget
          RaceTopBar(formatElapsedTime: formatElapsedTime),

          // Segment tabs widget
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentTabButton(
                  segmentType: SegmentType.swim,
                  currentSegment: _currentSegment,
                  label: "SWIM",
                  onTap: () {
                    setState(() {
                      _currentSegment = SegmentType.swim;
                    });
                  },
                ),
                SegmentTabButton(
                  segmentType: SegmentType.cycle,
                  currentSegment: _currentSegment,
                  label: "CYCLE",
                  onTap: () {
                    setState(() {
                      _currentSegment = SegmentType.cycle;
                    });
                  },
                ),
                SegmentTabButton(
                  segmentType: SegmentType.run,
                  currentSegment: _currentSegment,
                  label: "RUN",
                  onTap: () {
                    setState(() {
                      _currentSegment = SegmentType.run;
                    });
                  },
                ),
              ],
            ),
          ),

          // Participant grid widget
          Expanded(
            child: Expanded(
              child: ParticipantGrid(
                currentSegment: _currentSegment,
                formatElapsedTime: formatElapsedTime,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
