import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';  // Assuming you have a Segment model.
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/ui/widgets/actions/race_text_button.dart'; // Import the RaceTextButton
import 'package:race_tracking_app/ui/widgets/alerts/success_alert_dialog.dart'; // Import the SuccessAlertDialog

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
            RaceTextButton(
              text: 'Update Participant',
              onPressed: () {
                final name = _nameController.text;
                final bib = _bibController.text;

                if (name.isNotEmpty && bib.isNotEmpty) {
                  try {
                    // Update the participant while keeping the same segments
                    Provider.of<ParticipantProvider>(context, listen: false)
                        .updateParticipant(widget.participant.bib, name, bib, _segments);

                    // Show success message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SuccessAlertDialog(
                          message: 'Participant updated successfully!',
                        );
                      },
                    );

                    // Close the dialog and screen after a delay
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context).pop(); // Optionally, pop the screen
                    });
                  } catch (e) {
                    // Show error message if an issue occurs
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                } else {
                  // Show validation error if fields are empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in both fields.')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
