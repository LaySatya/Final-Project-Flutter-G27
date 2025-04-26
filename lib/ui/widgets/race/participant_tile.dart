import 'package:flutter/material.dart';

class ParticipantTile extends StatelessWidget {
  final String bib;
  final String name;

  const ParticipantTile({super.key, required this.bib, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(bib),
      ),
      title: Text(name),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          // Navigate to edit participant screen
          Navigator.pushNamed(context, '/editParticipant');
        },
      ),
    );
  }
}
