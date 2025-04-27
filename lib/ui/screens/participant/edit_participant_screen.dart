import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/models/segment.dart';  // Assuming you have a Segment model.
import 'package:race_tracking_app/models/participant.dart';

class EditParticipantScreen extends StatefulWidget {
  final Participant participant;

  EditParticipantScreen({required this.participant});

  @override
  _EditParticipantScreenState createState() => _EditParticipantScreenState();
}

class _EditParticipantScreenState extends State<EditParticipantScreen> {
  final _nameController = TextEditingController();
  final _bibController = TextEditingController();

  // Assuming the segments will remain the same
  late Map<SegmentType, Segment> _segments;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.participant.name;
    _bibController.text = widget.participant.bib;
    _segments = widget.participant.segments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Participant'),
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
                  // Update the participant while keeping the same segments
                  Provider.of<ParticipantProvider>(context, listen: false)
                      .updateParticipant(widget.participant.bib, name, bib, _segments);

                  Navigator.pop(context);
                }
              },
              child: Text('Update Participant'),
            ),
          ],
        ),
      ),
    );
  }
}
