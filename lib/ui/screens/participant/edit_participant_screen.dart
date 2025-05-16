import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/ui/widgets/alerts/success_alert_dialog.dart';

class EditParticipantScreen extends StatefulWidget {
  final Participant participant;

  const EditParticipantScreen({Key? key, required this.participant})
    : super(key: key);

  @override
  _EditParticipantScreenState createState() => _EditParticipantScreenState();
}

class _EditParticipantScreenState extends State<EditParticipantScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _bibController;
  late Map<SegmentType, Segment> _segments;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.participant.name);
    _bibController = TextEditingController(text: widget.participant.bib);
    _segments = widget.participant.segments;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bibController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Participant'),
        centerTitle: true,
        elevation: 0,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.save_outlined),
        //     onPressed: _updateParticipant,
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'Edit Participant Details',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.deepPurple[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Update the information below',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 32),

              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.deepPurple[400],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // BIB Field
              TextFormField(
                controller: _bibController,
                decoration: InputDecoration(
                  labelText: 'BIB Number',
                  prefixIcon: Icon(
                    Icons.confirmation_number_outlined,
                    color: Colors.deepPurple[400],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a BIB number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Update Button
              ElevatedButton(
                onPressed: _updateParticipant,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Update Participant',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateParticipant() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text;
    final bib = _bibController.text;

    try {
      await Provider.of<ParticipantProvider>(
        context,
        listen: false,
      ).updateParticipant(widget.participant.id, name, bib, _segments);

      // Show success message
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SuccessAlertDialog(
            message: 'Participant updated successfully!',
          );
        },
      ).then((_) {
        if (mounted) Navigator.of(context).pop();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}
