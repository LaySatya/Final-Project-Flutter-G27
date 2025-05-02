import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/ui/screens/result/widgets/animation_participant_tile.dart';
import 'package:race_tracking_app/ui/screens/result/widgets/header_text.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';
import 'package:race_tracking_app/ui/widgets/race_elapsed_time_topbar.dart';

import '../../../models/participant.dart';
import '../../../providers/participant_provider.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final participants = Provider.of<ParticipantProvider>(context).participants;

    // Sort by total time - sum time of all segements
    final sortedParticipants = List<Participant>.from(participants)
      ..sort((a, b) {
        final aTime = a.totalTime;
        final bTime = b.totalTime;
        return aTime.compareTo(bTime);
      });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Timer Bar
          RaceTopBar(formatElapsedTime: formatElapsedTime),

          const SizedBox(height: 8),

          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: const [
                HeaderText('RANK', flex: 2),
                HeaderText('BIB', flex: 2),
                HeaderText('NAME', flex: 4),
                HeaderText('TIME', flex: 3),
                HeaderText('Detail', flex: 0)
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Participant List
          Expanded(
            child: ListView.builder(
              itemCount: sortedParticipants.length,
              itemBuilder: (context, index) {
                final participant = sortedParticipants[index];
                final time = participant.totalTime;

                return AnimatedParticipantTile(
                  rank: index + 1,
                  participant: participant,
                  formattedTime: time > 0 ? formatTime(time) : '--',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}


