import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/ui/utils/rank_utils.dart';

class AnimatedParticipantTile extends StatelessWidget {
  final int rank;
  final Participant participant;
  final String formattedTime;

  const AnimatedParticipantTile({
    Key? key,
    required this.rank,
    required this.participant,
    required this.formattedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color rankColor = rank == 1 ? Colors.amber : Colors.black;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      rankText(rank),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: rankColor,
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Text(participant.bib)),
                  Expanded(flex: 4, child: Text(participant.name)),
                  Expanded(flex: 3, child: Text(formattedTime)),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
