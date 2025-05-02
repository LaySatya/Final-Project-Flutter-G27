import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';

class ParticipantGrid extends StatelessWidget {
  final SegmentType currentSegment;
  final String Function(int seconds) formatElapsedTime;

  const ParticipantGrid({
    Key? key,
    required this.currentSegment,
    required this.formatElapsedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    final raceProvider = Provider.of<RaceProvider>(context);

    final participants = participantProvider.participants;

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Increased for smaller size
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 1,
      ),
      itemCount: participants.length,
      itemBuilder: (context, index) {
        final participant = participants[index];
        final segment = participant.segments[currentSegment];
        final isTracked = segment?.isTracked ?? false;
        final elapsed = segment?.timeInSeconds ?? 0;

        return GestureDetector(
          onTap: () {
            if (!raceProvider.isRaceOngoing) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Race must be ongoing to track!')),
              );
              return;
            }

            if (isTracked) {
              participantProvider.untrackSegment(participant.bib, currentSegment);
            } else {
              participantProvider.trackSegment(
                participant.bib,
                currentSegment,
                raceProvider.race.elapsedTime,
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isTracked ? Colors.blue.shade600 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isTracked ? Colors.blue : Colors.grey.shade400,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  participant.bib,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isTracked ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                if (isTracked)
                  Icon(Icons.check_circle, size: 14, color: Colors.white),
                if (isTracked)
                  Text(
                    formatElapsedTime(elapsed),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
