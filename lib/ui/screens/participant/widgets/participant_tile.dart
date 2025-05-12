import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/ui/screens/participant/edit_participant_screen.dart';
import 'package:race_tracking_app/ui/screens/participant/widgets/delete_dialog.dart';

class ParticipantTile extends StatelessWidget {
  final Participant participant;
  final ParticipantProvider participantProvider;

  const ParticipantTile({
    Key? key,
    required this.participant,
    required this.participantProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Participant avatar/initials
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color:
                    isDarkMode
                        ? Colors.blueGrey[800]
                        : theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Text(
                participant.name.isNotEmpty
                    ? participant.name.substring(0, 1).toUpperCase()
                    : '?',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: isDarkMode ? Colors.white : theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Participant info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    participant.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'BIB: ${participant.bib}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Action buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edit button
                IconButton(
                  icon: Icon(Icons.edit_outlined, size: 22),
                  color: isDarkMode ? Colors.blue[200] : Colors.blue[600],
                  splashRadius: 20,
                  onPressed: () => _navigateToEdit(context),
                ),

                // Delete button
                IconButton(
                  icon: Icon(Icons.delete_outline, size: 22),
                  color: isDarkMode ? Colors.red[200] : Colors.red[600],
                  splashRadius: 20,
                  onPressed: () => _showDeleteDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditParticipantScreen(participant: participant),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          id: participant.id,
          name: participant.name,
          participantProvider: participantProvider,
        );
      },
    );
  }
}
