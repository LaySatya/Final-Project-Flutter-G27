import 'package:flutter/material.dart';
import 'participant_tile.dart';

class ParticipantList extends StatelessWidget {
  const ParticipantList({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary mock data
    final participants = [
      {'bib': '101', 'name': 'John Doe'},
      {'bib': '102', 'name': 'Jane Smith'},
    ];

    return ListView.builder(
      itemCount: participants.length,
      itemBuilder: (context, index) {
        final participant = participants[index];
        return ParticipantTile(
          bib: participant['bib']!,
          name: participant['name']!,
        );
      },
    );
  }
}
