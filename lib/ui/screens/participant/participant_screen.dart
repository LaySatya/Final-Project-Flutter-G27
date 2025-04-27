import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/ui/screens/participant/add_participant_screen.dart';
import 'package:race_tracking_app/ui/screens/participant/widgets/participant_tile.dart';

class ParticipantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    final participants = participantProvider.participants;

    return Scaffold(
      appBar: AppBar(
        title: Text('Participants'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddParticipantScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: participants.length,
        itemBuilder: (context, index) {
          final participant = participants[index];
          return ParticipantTile(
            participant: participant,
            participantProvider: participantProvider,
          );
        },
      ),
    );
  }
}
