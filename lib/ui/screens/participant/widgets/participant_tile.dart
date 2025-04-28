import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/ui/screens/participant/edit_participant_screen.dart';
import 'package:race_tracking_app/ui/screens/participant/widgets/delete_dialog.dart';

class ParticipantTile extends StatelessWidget {
  final Participant participant;
  final ParticipantProvider participantProvider;

  ParticipantTile({
    required this.participant,
    required this.participantProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(participant.name),
      subtitle: Text('BIB: ${participant.bib}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Edit button
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blue,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditParticipantScreen(participant: participant),
                ),
              );
            },
          ),
          // Delete button
          IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent,),
            onPressed: () {
              // Show the delete confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeleteConfirmationDialog(
                    bib: participant.bib,
                    participantProvider: participantProvider,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
