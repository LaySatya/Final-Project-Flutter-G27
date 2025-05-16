import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/segment_tracking_provider.dart';
import 'package:race_tracking_app/ui/screens/result/widgets/summary_item.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';

class ResultsSummaryCard extends StatelessWidget {
  final List<Participant> participants;
  final SegmentTrackingProvider trackingProvider;

  const ResultsSummaryCard({
    super.key,
    required this.participants,
    required this.trackingProvider,
  });

  // get total time
  int _getTotalTime(Participant p) {
    int totalTime = 0;
    for (final type in SegmentType.values) {
      totalTime += trackingProvider.getSegmentTime(p.id, type);
    }
    return totalTime;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final times =
        participants
            .map((p) => _getTotalTime(p))
            .where((time) => time > 0)
            .toList();

    final fastest = times.isEmpty ? 0 : times.reduce((a, b) => a < b ? a : b);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SummaryItem(
              Icons.people,
              'Participants',
              participants.length.toString(),
              theme.colorScheme.primary,
            ),
            SummaryItem(
              Icons.timer,
              'Fastest',
              formatElapsedTime(fastest),
              theme.colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
