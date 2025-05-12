import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/segment_tracking_provider.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';

class ResultsSummaryCard extends StatelessWidget {
  final List<Participant> participants;
  final SegmentTrackingProvider trackingProvider;

  const ResultsSummaryCard({
    super.key,
    required this.participants,
    required this.trackingProvider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final times =
        participants
            .map((p) => _getTotalTime(p))
            .where((time) => time > 0)
            .toList();

    final fastest = times.isEmpty ? 0 : times.reduce((a, b) => a < b ? a : b);
    final avgTime =
        times.isEmpty ? 0 : times.reduce((a, b) => a + b) ~/ times.length;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryItem(
              context,
              Icons.people,
              'Participants',
              participants.length.toString(),
              theme.colorScheme.primary,
            ),
            _buildSummaryItem(
              context,
              Icons.timer,
              'Fastest',
              formatElapsedTime(fastest),
              theme.colorScheme.secondary,
            ),
            _buildSummaryItem(
              context,
              Icons.av_timer,
              'Avg Time',
              formatElapsedTime(avgTime),
              theme.colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, size: 28, color: color),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  int _getTotalTime(Participant p) {
    int totalTime = 0;
    for (final type in SegmentType.values) {
      totalTime += trackingProvider.getSegmentTime(p.id, type);
    }
    return totalTime;
  }
}
