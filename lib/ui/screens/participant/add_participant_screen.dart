import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/models/segment.dart';  // Assuming you have a Segment model.
import 'package:race_tracking_app/models/participant.dart';

class AddParticipantScreen extends StatefulWidget {
  @override
  _AddParticipantScreenState createState() => _AddParticipantScreenState();
}

class _AddParticipantScreenState extends State<AddParticipantScreen> {
  final _nameController = TextEditingController();
  final _bibController = TextEditingController();

  // You can predefine some segments if needed
  final Map<SegmentType, Segment> _segments = {};  // Empty segments map for now

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Participant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _bibController,
              decoration: InputDecoration(labelText: 'BIB'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final bib = _bibController.text;

                if (name.isNotEmpty && bib.isNotEmpty) {
                  // Create the new participant with an empty segment map
                  Provider.of<ParticipantProvider>(context, listen: false)
                      .addParticipant(name, bib, _segments);

                  Navigator.pop(context);
                }
              },
              child: Text('Add Participant'),
            ),
          ],
        ),
      ),
    );
  }
}
