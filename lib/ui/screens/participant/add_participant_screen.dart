import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/models/segment.dart'; // Assuming you have a Segment model.
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/ui/widgets/actions/race_text_button.dart';
import 'package:race_tracking_app/ui/widgets/alerts/success_alert_dialog.dart'; // Import SuccessAlertDialog

class AddParticipantScreen extends StatefulWidget {
  @override
  _AddParticipantScreenState createState() => _AddParticipantScreenState();
}

class _AddParticipantScreenState extends State<AddParticipantScreen> {
  final _nameController = TextEditingController();
  final _bibController = TextEditingController();

  // You can predefine some segments if needed
  final Map<SegmentType, Segment> _segments = {}; // Empty segments map for now

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
            
            // add participant button
            RaceTextButton(
              text: "Add Participant",
              onPressed: () {
                final name = _nameController.text;
                final bib = _bibController.text;

                if (name.isNotEmpty && bib.isNotEmpty) {
                  try {
                    // Attempt to add the participant
                    Provider.of<ParticipantProvider>(context, listen: false)
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
                      Navigator.of(context).pop(); // Optionally, pop the screen
                    });
                  } catch (e) {
                    // Show error message if BIB already exists
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${e.toString()}')),
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
