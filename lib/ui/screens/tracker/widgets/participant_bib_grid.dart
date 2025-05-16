import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';
import 'package:race_tracking_app/providers/segment_tracking_provider.dart';

class ParticipantGrid extends StatelessWidget {
  final SegmentType currentSegment;
  final String Function(int seconds) formatElapsedTime;
  final Function(Participant) onBibTap;

  const ParticipantGrid({
    Key? key,
    required this.currentSegment,
    required this.formatElapsedTime,
    required this.onBibTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    final segmentProvider = Provider.of<SegmentTrackingProvider>(context);
    // final raceProvider = Provider.of<RaceProvider>(context);
    final theme = Theme.of(context);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: participantProvider.participants.length,
      itemBuilder: (context, index) {
        final participant = participantProvider.participants[index];
        final isTracked = segmentProvider.isTracked(
          participant.id,
          currentSegment,
        );
        final segment = segmentProvider.getTrackedSegment(
          participant.id,
          currentSegment,
        );
        final elapsed = segment?.timeInSeconds ?? 0;

        return _buildBibCard(context, participant, isTracked, elapsed, theme);
      },
    );
  }

  Widget _buildBibCard(
    BuildContext context,
    Participant participant,
    bool isTracked,
    int elapsed,
    ThemeData theme,
  ) {
    return GestureDetector(
      onTap: () => onBibTap(participant),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isTracked ? Colors.deepPurple[600] : theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: isTracked ? Colors.deepPurple[800]! : theme.dividerColor,
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bib Number
            Text(
              participant.bib,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    isTracked
                        ? Colors.white
                        : theme.textTheme.titleMedium?.color,
              ),
            ),
            const SizedBox(height: 8),

            // Tracking Status
            if (elapsed > 0 && !isTracked)
              Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 18),
                  const SizedBox(height: 4),
                  Text(
                    formatElapsedTime(elapsed),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            else if (isTracked)
              Column(
                children: [
                  const Icon(Icons.timer, size: 18, color: Colors.white),
                  const SizedBox(height: 4),
                  Text(
                    'Tracking...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Icon(
                    Icons.timer_off,
                    size: 18,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to track',
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
