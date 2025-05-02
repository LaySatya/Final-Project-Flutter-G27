import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/ui/widgets/alerts/success_alert_dialog.dart';
import 'package:race_tracking_app/ui/widgets/button/race_text_button.dart';

class AddParticipantScreen extends StatefulWidget {
  @override
  _AddParticipantScreenState createState() => _AddParticipantScreenState();
}

class _AddParticipantScreenState extends State<AddParticipantScreen> {
  final _nameController = TextEditingController();
  final _bibController = TextEditingController();

  final Map<SegmentType, Segment> _segments = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Participant')),
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
            // Add participant button
            RaceTextButton(
              text: "Add Participant",
              onPressed: () async {
                final name = _nameController.text;
                final bib = _bibController.text;

                if (name.isNotEmpty && bib.isNotEmpty) {
                  try {
                    
                    // Attempt to add the participant
                    await Provider.of<ParticipantProvider>(context, listen: false)
                        .addParticipant(name, bib, _segments);

                    // Show success message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SuccessAlertDialog(
                          message: 'Participant added successfully!',
                        );
                      },
                    );

                    // Close the dialog and screen after a delay
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context).pop(); // pop the screen
                    });
                  } catch (e) {
                    // Show error message if BIB already exists
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
