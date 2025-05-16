import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/segment_tracking_provider.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';

class ResultsList extends StatelessWidget {
  final List<Participant> participants;
  final SegmentTrackingProvider trackingProvider;

  const ResultsList({
    super.key,
    required this.participants,
    required this.trackingProvider,
  });

  Color _getMedalColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFFD700); // Gold
      case 1:
        return const Color(0xFFC0C0C0); // Silver
      case 2:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return Colors.grey[300]!; // Default
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedParticipants = List<Participant>.from(participants)
      ..sort((a, b) => _getTotalTime(a).compareTo(_getTotalTime(b)));

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: sortedParticipants.length,
      itemBuilder: (context, index) {
        final participant = sortedParticipants[index];
        final totalTime = _getTotalTime(participant);

        return Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: _getMedalColor(index),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            title: Text(
              participant.name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'BIB: ${participant.bib}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(
              formatElapsedTime(totalTime),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children:
                      SegmentType.values.map((type) {
                        final timeInSeconds = trackingProvider.getSegmentTime(
                          participant.id,
                          type,
                        );
                        return _buildSegmentRow(type.name, timeInSeconds);
                      }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSegmentRow(String label, int timeInSeconds) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            timeInSeconds > 0 ? formatElapsedTime(timeInSeconds) : '--',
            style: const TextStyle(
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
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
