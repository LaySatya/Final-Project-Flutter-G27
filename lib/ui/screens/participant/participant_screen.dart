import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/ui/screens/participant/add_participant_screen.dart';
import 'package:race_tracking_app/ui/screens/participant/widgets/empty_participant.dart';
import 'package:race_tracking_app/ui/screens/participant/widgets/participant_tile.dart';

class ParticipantsScreen extends StatefulWidget {
  @override
  _ParticipantsScreenState createState() => _ParticipantsScreenState();
}

class _ParticipantsScreenState extends State<ParticipantsScreen> {
  @override
  void initState() {
    super.initState();
      Provider.of<ParticipantProvider>(context, listen: false).loadParticipants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Participants'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToAddParticipantScreen(context),
          ),
        ],
      ),
      body: Consumer<ParticipantProvider>(
        builder: (context, participantProvider, child) {
          final participants = participantProvider.participants;

          // Show a loading
          if (participants.isEmpty) {
            return Center(child: EmptyParticipant());
          }

          return ListView.builder(
            itemCount: participants.length,
            itemBuilder: (context, index) {
              final participant = participants[index];
              return ParticipantTile(
                participant: participant,
                participantProvider: participantProvider,
              );
            },
          );
        },
      ),
    );
  }

  // navigate to add participant screen
  void _navigateToAddParticipantScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddParticipantScreen()),
    );
  }
}
