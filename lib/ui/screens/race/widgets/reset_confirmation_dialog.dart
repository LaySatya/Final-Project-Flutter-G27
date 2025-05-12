import 'package:flutter/material.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';

Future<void> showResetConfirmationDialog(
  BuildContext context,
  RaceProvider raceProvider,
  ParticipantProvider participantProvider,
) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Reset Race?'),
        content: const Text(
          'This will reset all race times and participant data. Continue?',
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
            onPressed: () {
              raceProvider.resetRace();
              participantProvider.resetAllParticipants();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Race and all participants have been reset',
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
