import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/participant.dart';

class ResultDetailScreen extends StatelessWidget {
  final Participant participant;

  const ResultDetailScreen({Key? key, required this.participant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Detail'),
      ),
      body: Center(
        child: Text(
          'Participant: ${participant.name}',
        ),
      ),
    );
  }
}
