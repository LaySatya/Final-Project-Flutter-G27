import 'package:flutter/material.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String bib;
  final ParticipantProvider participantProvider;

  DeleteConfirmationDialog({
    required this.bib,
    required this.participantProvider,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Participant'),
      content: Text('Are you sure you want to delete this participant?'),
      actions: [
        TextButton(
          onPressed: () {
            participantProvider.deleteParticipant(bib);
            Navigator.of(context).pop();
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No'),
        ),
      ],
    );
  }
}
